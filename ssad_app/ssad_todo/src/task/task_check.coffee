# task_check.coffee, ssad/ssad_app/ssad_todo/src/task/

time = require '../time/time'
time_parse = require '../time/time_parse'


# TODO improve: strict task time check ?

_check_unit_throw = (raw, throw_not_unit) ->
  for i in raw
    if (i.type != time_parse.TYPE_UNIT) and throw_not_unit
      throw new Error "time type must be unit"
    if (i.type is time_parse.TYPE_UNIT) and (! throw_not_unit)
      throw new Error "unit time type not allowed"


check_time_planned_start = (text) ->
  o = time_parse.parse_time_str text
  # TODO improve: different checks for oneshot / regular ?  (strict time check)
  # at least one item
  if o.length < 1
    throw new Error "empty time_planned_start"
  # not allow unit time
  _check_unit_throw o, false
  # check pass

check_time_ddl = (text) ->
  o = time_parse.parse_time_str text
  # TODO improve: strict time check ?
  # at least one item
  if o.length < 1
    throw new Error "empty time_ddl"
  # not allow unit time
  _check_unit_throw o, false
  # check pass

check_time_duration_limit = (text) ->
  o = time_parse.parse_time_str text
  # TODO improve: strict check ?
  # only one item is allowed
  if o.length != 1
    throw new Error "time_duration_limit length != 1"
  # check type: allow hour_minute
  if o[0].type is time_parse.TYPE_HOUR_MINUTE
    return  # check pass
  # only unit is allowed
  _check_unit_throw o, true
  # check pass

check_time_auto_ready = (text) ->
  o = time_parse.parse_time_str text
  # TODO improve: strict check ?
  # at least one item
  if o.length < 1
    throw new Error "empty auto_ready"
  # check pass

check_time_interval = (text) ->
  o = time_parse.parse_time_str text
  # TODO improve: strict check ?
  # only one item is allowed
  if o.length != 1
    throw new Error "time_interval length != 1"
  # type must be unit
  if o[0].type != time_parse.TYPE_UNIT
    throw new Error "time_interval is not unit"
  # check pass


_print_time = (text) ->
  data = time_parse.parse_time_str text
  time.print_time data

check_form = (data) ->
  _STATE_OK = 'success'
  _STATE_ERROR = 'error'
  _STATE_WARN = 'warning'

  o = {}
  # skip task_id (not check)
  # check title (required)
  if data.title.trim() is ''
    o.title = {
      state: _STATE_ERROR
      text: 'ERROR: title is REQUIRED'
    }
  else
    o.title = {
      state: _STATE_OK
    }
  # skip desc (optional)
  _check_optional_time = (text, check) ->
    if text.trim() is ''
      oo = {
        text: '(optional)'
      }
    else
      try
        check text
        # print time_str
        oo = {
          state: _STATE_OK
          text: _print_time text
        }
      catch e
        oo = {
          state: _STATE_ERROR
          text: "ERROR: #{e}"
        }
    oo
  # check time.planned_start (optional)
  o.time_planned_start = _check_optional_time data.time.planned_start, check_time_planned_start
  # check time.ddl (optional)
  o.time_ddl = _check_optional_time data.time.ddl, check_time_ddl
  # check time.duration_limit (optional)
  o.time_duration_limit = _check_optional_time data.time.duration_limit, check_time_duration_limit
  # check time.auto_ready (optional)
  o.time_auto_ready = _check_optional_time data.time.auto_ready, check_time_auto_ready

  # task regular:
  if data.type is 'regular'
    # check time.interval (required)
    if data.time.interval.trim() is ''
      o.time_interval = {
        state: _STATE_ERROR
        text: 'ERROR: time.interval is REQUIRED'
      }
    else
      try
        check_time_interval data.time.interval
        o.time_interval = {
          state: _STATE_OK
          text: _print_time data.time.interval
        }
      catch e
        o.time_interval = {
          state: _STATE_ERROR
          text: "ERROR: #{e}"
        }
  else
    o.time_interval = {}
  o


check_task_change = (old, d) ->
  o = old.raw.data
  # skip: 'task_id', 'type' must be same

  # check title
  if o.title != d.title
    throw "title changed"
  # check desc
  if o.desc != d.desc
    throw "desc changed"
  # check optional attr
  _check_opt_attr = (old, b, text) ->
    if old?
      old = old.trim()
    b = b.trim()
    if b is ''
      b = null
    # if one is null, another is not, throw
    if (old? and (! b?)) or ((! old?) and b?)
      throw text
    # both is not null
    if (old? and b?) and (old != b)
      throw text
    # else: both null
  _check_opt_attr o.time.planned_start, d.time.planned_start, 'time.planned_start'
  _check_opt_attr o.time.ddl, d.time.ddl, 'time.ddl'
  _check_opt_attr o.time.duration_limit, d.time.duration_limit, 'time.duration_limit'
  _check_opt_attr o.time.auto_ready, d.time.auto_ready, 'time.auto_ready'

  # checks only for regular task
  if o.type is 'regular'
    _check_opt_attr o.time.interval, d.time.interval, 'time.interval'
    _check_opt_attr o.time_base, d.time_base, 'time_base'
  # check done


module.exports = {
  check_time_planned_start  # throw
  check_time_ddl  # throw
  check_time_duration_limit  # throw
  check_time_auto_ready  # throw
  check_time_interval  # throw

  check_form
  check_task_change  # throw
}
