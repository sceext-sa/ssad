# r_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_edit_create_task'


# $$o: state.main.edit_task
reducer = ($$o, action) ->
  switch action.type
    when ac.ET_RESET
      $$o = Immutable.fromJS state.main.edit_task
    when ac.ET_SET_TASK_ID
      $$o = $$o.set 'task_id', action.payload
    when ac.ET_SET_TYPE
      $$o = $$o.set 'type', action.payload
    when ac.ET_SET_TITLE
      $$o = $$o.set 'title', action.payload
    when ac.ET_SET_DESC
      $$o = $$o.set 'desc', action.payload
    when ac.ET_SET_TIME_PLANNED_START
      $$o = $$o.setIn ['time', 'planned_start'], action.payload
    when ac.ET_SET_TIME_DDL
      $$o = $$o.setIn ['time', 'ddl'], action.payload
    when ac.ET_SET_TIME_DURATION_LIMIT
      $$o = $$o.setIn ['time', 'duration_limit'], action.payload
    when ac.ET_SET_TIME_AUTO_READY
      $$o = $$o.setIn ['time', 'auto_ready'], action.payload
    when ac.ET_SET_TIME_INTERVAL
      $$o = $$o.setIn ['time', 'interval'], action.payload
    when ac.ET_SET_TIME_BASE
      $$o = $$o.set 'time_base', action.payload
    #when ac.EDIT_TASK_COMMIT
  $$o

module.exports = reducer
