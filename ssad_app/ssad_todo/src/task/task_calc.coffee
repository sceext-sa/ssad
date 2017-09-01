# task_calc.coffee, ssad/ssad_app/ssad_todo/src/task/

task_status = require '../td/task_status'
one_task = require '../td/one_task'
time = require '../time/time'
time_parse = require '../time/time_parse'
time_print = require '../time/time_print'

auto_ready = require './auto_ready'


_make_history_index = (task) ->
  history_name = Object.keys task.history
  history_name.sort()
  history_name.reverse()  # latest history first
  history_name

# get current status of one task from history items
_get_current_status = (task) ->
  for i in _make_history_index(task)
    h = task.history[i]
    if h.data.status?
      return h.data.status
  # no history item has `status`
  task_status.INIT

# get latest task comment, or task desc
_get_latest_text = (task) ->
  for i in _make_history_index(task)
    h = task.history[i]
    if h.data.note?
      return h.data.note
  # no 'note' history, use task desc
  desc = task.raw.data.desc
  if ! desc?
    desc = ''  # use empty str
  desc

# task last update time, for sort task
_get_last_time = (task) ->
  # get all history time
  ht = Object.keys task.history_list
  # add one: task raw last_update time
  ht.push task.raw._time
  # sort time
  ht.sort()
  ht.reverse()  # use latest one
  ht[0]


_is_task_disabled = (task_id, enable_list) ->
  enable_list.indexOf(task_id) is -1

# calc attr
calc_one_task = (task_id, task, enable_list) ->
  o = {
    disabled: _is_task_disabled task_id, enable_list
    status: _get_current_status task
    text: _get_latest_text task
    last_time: _get_last_time task

    first_status: null
    second_status: task_status.SECOND_OUT  # out by default
    last_end: ''

    planned_start: null
    ddl: null
    is_ready: false
  }
  # status and first_status, second_status
  if o.disabled
    o.status = task_status.DISABLED
  else
    o.first_status = o.status
    o.second_status = _get_second_status o.first_status
    # last_end
    o.last_end = _get_last_end task
    # planned_start
    o.planned_start = _calc_planned_start task, o
    # FIXME
    if o.planned_start? and o.planned_start.toISOString?
      o.planned_start = o.planned_start.toISOString()
    # TODO ddl ?
    # TODO fix planned_start / ddl ?

    # is_ready
    is_ready = auto_ready.is_ready task, o
    if is_ready is true
      o.is_ready = is_ready
    else
      o.auto_ready = is_ready  # only for DEBUG
    # check status for 'ready'
    if o.is_ready and (task_status.CLASS_M.indexOf(o.first_status) is -1) and (o.first_status != task_status.WAIT)
      o.status = task_status.READY
  o


_get_second_status = (first_status) ->
  if task_status.CLASS_M.indexOf(first_status) != -1
    task_status.SECOND_IN
  else
    task_status.SECOND_OUT

_get_last_end = (task) ->
  loaded_history = Object.keys task.history
  loaded_history.sort()
  loaded_history.reverse()  # latest history first
  for i in loaded_history
    status = task.history[i].data.status
    if status? and (task_status.CLASS_END.indexOf(status) != -1)
      return i
  # init task, use task create (update) time
  task.raw._time

# directly planned_start from task config (task.raw)
_calc_planned_start = (task, calc) ->
  rd = task.raw.data
  # check time.planned_start
  ps = rd.time.planned_start
  # check task type
  if rd.type != one_task.TASK_TYPE_R  # oneshot, not regular
    if (! ps?) or (ps.trim() is '')
      return null  # not support empty planned_start
    t = time.parse_time_str ps
    # check time length
    if t.length != 1
      return 'not support (oneshot: t.length)'
    t = t[0]
    # check time type
    switch t.type
      when time_parse.TYPE_ISO_TIME, time_parse.TYPE_ISO_DATE
        # TODO fix TYPE_ISO_DATE ?
        return t.data.toISOString()
    return 'not support (oneshot: time type)'
  # regular

  # check time_base
  switch rd.time_base
    when one_task.TIME_BASE_FIXED
      return _calc_psr_fixed task, calc, ps
    when one_task.TIME_BASE_LAST
      return _calc_psr_last task, calc, ps

  # TODO support other type ?
  'not support (return)'

# calc task planned_start, regular, fixed
_calc_psr_fixed = (task, calc, ps) ->
  if (! ps?) or (ps.trim() is '')
    return null  # not support empty planned_start
  ps = time.parse_time_str ps

  rd = task.raw.data
  # check sub type
  interval = rd.time.interval
  if interval? and (interval.trim() != '')
    interval = time.parse_time_str interval
  else
    return 'not support (regular fixed: no interval)'
  # interval: len 1, fixed, unit
  if (interval.length is 1) and (interval[0].type is time_parse.TYPE_UNIT)
    i = interval[0]
    switch i.unit
      when 'd'  # days
        # only support one day (everyday)
        if i.value != 1
          return 'not support (regular fixed: not 1 day)'
        if ps.length != 1
          return 'not support (regular fixed: ps.length)'
        # only support ps: hour_minute
        if ps[0].type != time_parse.TYPE_HOUR_MINUTE
          return 'not support (regular fixed 1 day: ps not hour_minute)'
        # sub type check OK
        return _sub_type_psr_fixed_one_day_hour_minute calc, ps[0]
      when 'w'  # weeks
        # only support one week (everyweek)
        if i.value != 1
          return 'not support (regular fixed: not 1 week)'
        # check ps: day_in_week
        if ps[0].type != time_parse.TYPE_DAY_IN_WEEK
          return 'not support (regular fixed: ps: not day_in_week)'
        # sub type check OK
        return _sub_type_psr_fixed_one_week_day_in_week ps
      else
        return 'not support (regular fixed: interval unit)'

  # TODO support other type ?
  'not support (ps r, fixed)'

# calc task planned_start, regular, last
_calc_psr_last = (task, calc, ps) ->
  rd = task.raw.data
  # check sub type
  interval = rd.time.interval
  if interval? and (interval.trim() != '')
    interval = time.parse_time_str interval
  else
    return 'not support (regular last: no interval)'
  # interval: len 1, last, unit
  if (interval.length is 1) and (interval[0].type is time_parse.TYPE_UNIT)
    i = interval[0]
    switch i.unit
      when 'd', 'w'  # days, weeks
        if i.unit is 'w'
          days = i.value * 7  # weeks as days
        else
          days = i.value
        # sub type check OK
        return _sub_type_psr_last_days task, calc, days
      else
        return 'not support (regular last: interval unit)'

  # TODO support other type ?
  'not support (ps r, last)'


# calc.planned_start: sub types

_sub_type_psr_fixed_one_day_hour_minute = (calc, ps) ->
  now = new Date()
  o = time_print.offset_date now
  # make today's ps
  o.setUTCHours ps.hour
  o.setUTCMinutes ps.minute

  # check last_end is today
  last_end = new Date calc.last_end
  last_end = time_print.offset_date last_end
  if o.toISOString().split('T')[0] is last_end.toISOString().split('T')[0]
    in_today = true
  else
    in_today = false

  o = time_print.r_offset_date o
  # check today passed
  if (now.getTime() > o.getTime()) and in_today  # if not today done, never use tomorrow
    # tomorrow
    t = o.getTime() + 86400 * 1e3
    o.setTime t
  # reset time
  o.setUTCSeconds 0
  o.setUTCMilliseconds 0
  o

_sub_type_psr_fixed_one_week_day_in_week = (ps) ->
  WEEK_DAY_N = 7  # 7 days in one week

  p = ps[0]
  # make this week's ps
  now = new Date()
  o = time_print.offset_date now
  # reset hour, minute, second, ms
  o.setUTCHours 0
  o.setUTCMinutes 0
  o.setUTCSeconds 0
  o.setUTCMilliseconds 0

  week = o.getUTCDay()
  # check this week passed
  if week > p.data
    # use next week
    t = o.getTime() + WEEK_DAY_N * 86400 * 1e3
    o.setTime t

    offset_day = p.data - week
  else  # use this week
    offset_day = p.data - week
  # offset day
  t = o.getTime() + offset_day * 86400 * 1e3
  o.setTime t

  # check hour_minute
  if ps.length is 2
    p = ps[1]
    if p.type is time_parse.TYPE_HOUR_MINUTE
      # set hour-minute
      o.setUTCHours p.hour
      o.setUTCMinutes p.minute
      # TODO FIXME not check passed here
    else
      return 'not support (_sub_type_psr_fixed_one_week_day_in_week: ps type: not 2: mour_minute)'
  else if ps.length > 2
    return 'not support (_sub_type_psr_fixed_one_week_day_in_week: ps.length)'

  o = time_print.r_offset_date o


# TODO check ps ?  (now not check)
_sub_type_psr_last_days = (task, calc, days) ->
  last_end = new Date(calc.last_end)
  # TODO check last_end ?

  # offset days
  o = time_print.offset_date last_end
  o.setUTCHours 0  # reset to one day
  o.setUTCMinutes 0
  o.setUTCSeconds 0
  o.setUTCMilliseconds 0
  # add days
  t = o.getTime() + days * 86400 * 1e3
  o.setTime t

  time_print.r_offset_date o


module.exports = {
  calc_one_task
}
