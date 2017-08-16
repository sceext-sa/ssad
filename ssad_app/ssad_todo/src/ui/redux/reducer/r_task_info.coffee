# r_task_info.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_task_info'

# $$o: state.main.task_info
reducer = ($$o, action) ->
  switch action.type
    when ac.TI_LOAD_TASKS
      $$data = Immutable.fromJS action.payload
      $$o = $$o.update 'task', ($$task) ->
        $$task.merge $$data
    when ac.TI_LOAD_HISTORIES
      { task_id } = action.payload
      $$data = Immutable.fromJS action.payload.data
      $$o = $$o.updateIn ['task', task_id, 'history'], ($$h) ->
        $$h.merge $$data
    when ac.TI_SET_HISTORY_HIDE
      {
        task_id
        history_name
        hide
      } = action.payload
      $$o = $$o.setIn ['task', task_id, 'history', history_name, 'hide'], hide
    when ac.TI_UPDATE_ENABLE_LIST
      $$data = Immutable.fromJS action.payload
      $$o = $$o.update 'enable_list', ($$list) ->
        $$list.merge $$data
    when ac.TI_UPDATE_DISABLED_LIST
      $$data = Immutable.fromJS action.payload
      $$o = $$o.update 'disabled_list', ($$list) ->
        $$list.merge $$data
    when ac.TI_RESET
      $$o = Immutable.fromJS state.main.task_info
  $$o

module.exports = reducer
