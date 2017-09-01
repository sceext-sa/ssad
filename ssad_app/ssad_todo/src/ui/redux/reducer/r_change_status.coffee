# r_change_status.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_change_status'


# $$o: state.main.cs
reducer = ($$o, action) ->
  switch action.type
    when ac.CS_SET_TASK_ID
      $$o = $$o.set 'task_id', action.payload
    when ac.CS_SET_STATUS
      $$o = $$o.set 'status', action.payload
    when ac.CS_SET_DISABLED
      $$o = $$o.set 'disabled', action.payload
    when ac.CS_SET_COMMENT
      $$o = $$o.set 'comment', action.payload
    when ac.CS_RESET
      $$o = Immutable.fromJS state.main.cs
  $$o

module.exports = reducer
