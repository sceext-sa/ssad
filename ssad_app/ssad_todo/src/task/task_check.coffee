# task_check.coffee, ssad/ssad_app/ssad_todo/src/task/

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


module.exports = {
  check_time_planned_start  # throw
  check_time_ddl  # throw
  check_time_duration_limit  # throw
  check_time_interval  # throw
}
