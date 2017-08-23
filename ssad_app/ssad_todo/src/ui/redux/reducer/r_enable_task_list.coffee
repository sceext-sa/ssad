# r_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_enable_task_list'


# $$o: state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.ETL_CHANGE_LIST
      $$o = $$o.set 'show_list', action.payload
    when ac.ETL_SET_TASK_ID
      $$o = $$o.set 'task_id', action.payload
  $$o

module.exports = reducer
