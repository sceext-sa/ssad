# auto_ready.coffee, ssad/ssad_app/ssad_todo/src/task/

task_status = require '../td/task_status'
one_task = require '../td/one_task'
time = require '../time/time'
time_parse = require '../time/time_parse'
time_print = require '../time/time_print'


_is_good_time = (raw) ->
  d = new Date raw
  ! Number.isNaN d.getTime()


is_ready = (task, calc) ->
  rd = task.raw.data
  # check time.auto_ready
  ar = rd.time.auto_ready
  if (! ar?) or (ar.trim() is '')
    return false  # not support empty auto_ready
  ar = time.parse_time_str ar
  # check task type
  if rd.type != one_task.TASK_TYPE_R  # oneshot, not regular
    # only support len 1: iso_time / iso_date
    if ar.length != 1
      return 'not support (oneshot: length)'
    a = ar[0]
    switch a.type
      when time_parse.TYPE_ISO_TIME, time_parse.TYPE_ISO_DATE
        # check ready
        now = new Date()
        if now.getTime() > a.data.getTime()
          return true
        else
          return false
    return 'not support (oneshot: type)'
  # regular

  # check time_base
  switch rd.time_base
    when one_task.TIME_BASE_FIXED
      return _check_fixed rd, calc, ar
    when one_task.TIME_BASE_LAST
      return _check_last rd, calc, ar
  'not support (return)'


_check_fixed = (rd, calc, ar) ->
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
        if ar.length != 1
          return 'not support (regular fixed: length)'
        a = ar[0]
        # only support ar: hour_minute
        if a.type != time_parse.TYPE_HOUR_MINUTE
          return 'not support (regular fixed 1 day: not hour_minute)'
        # sub type check OK
        return _st_rf_1d_hour_minute calc, a
      when 'w'  # weeks
        # only support one week (everyweek)
        if i.value != 1
          return 'not support (regular fixed: not 1 week)'
        # check ar: day_in_week
        if ar[0].type != time_parse.TYPE_DAY_IN_WEEK
          return 'not support (regular fixed: not day_in_week)'
        # sub type check OK
        return _st_rf_1w_day_in_week ar
      else
        return 'not support (regular fixed: interval unit)'
  # TODO support more types ?
  'not support (regular fixed)'

_check_last = (rd, calc, ar) ->
  # only support ar type: day
  if ar.length != 1
    return 'not support (regular last: length)'
  a = ar[0]
  if a.type != time_parse.TYPE_UNIT
    return 'not support (regular last: not unit)'
  if a.unit != 'd'
    return 'not support (regular last: unit type not day)'
  # check days before planned_start
  ps = calc.planned_start
  if (! ps?) or (ps.trim() is '')
    return 'not support (regular last: no planned_start)'
  if ! _is_good_time(ps)
    return 'not support (regular last: bad planned_start)'
  p = new Date ps
  now = new Date()
  t = p.getTime() - a.value * 86400 * 1e3
  # check should ready
  if now.getTime() > t
    return true
  else
    return false

  # TODO support more type ?
  'not support (regular last)'


# fixed: sub types

_st_rf_1d_hour_minute = (calc, a) ->
  now = new Date()
  o = time_print.offset_date now
  # make today's ar
  o.setUTCHours a.hour
  o.setUTCMinutes a.minute

  # check last_end is today
  last_end = new Date calc.last_end
  last_end = time_print.offset_date last_end
  if o.toISOString().split('T')[0] is last_end.toISOString().split('T')[0]
    in_today = true
  else
    in_today = false
  if in_today
    return false  # never ready when today done

  o = time_print.r_offset_date o
  # check should ready  (today not done)
  if now.getTime() > o.getTime()
    return true
  else
    return false

_st_rf_1w_day_in_week = (ar) ->
  a = ar[0]
  # make this week's ar
  now = new Date()
  o = time_print.offset_date now
  # reset hour, minute, second, ms
  o.setUTCHours 0
  o.setUTCMinutes 0
  o.setUTCSeconds 0
  o.setUTCMilliseconds 0

  week = o.getUTCDay()
  # FIXME only ready at that day ?
  if week != a.data
    return false
  # check hour_minute
  if (ar.length > 1) and (ar[0].type is time_parse.TYPE_HOUR_MINUTE)
    a = ar[1]
    # make today now
    now = new Date()
    o = time_print.offset_date now
    o.setUTCHours a.hour
    o.setUTCMinutes a.minute

    o = time_print.r_offset_date o
    if now.getTime() > o.getTime()
      return true
    else
      return false
  else if ar.length > 2
    return 'not support (_st_rf_1w_day_in_week: ar.length)'
  else  # ar.length is 1
    return true


module.exports = {
  is_ready
}
