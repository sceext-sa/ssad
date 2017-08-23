# r_td.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_td'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.td
  $$o

# $$state: state.td
reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.TD_UPDATE_NEXT_TASK_ID
      $$o = $$o.set 'next_task_id', action.payload
    when ac.TD_UPDATE_TASK_LIST
      $$data = Immutable.fromJS action.payload
      $$o = $$o.set 'task_list', $$data
    when ac.TD_UPDATE_DISABLED_LIST
      $$data = Immutable.fromJS action.payload
      $$o = $$o.set 'disabled_list', $$data
    when ac.TD_UPDATE_HISTORY_LIST
      $$data = Immutable.fromJS action.payload.data
      # task must exist (loaded before)
      $$o = $$o.setIn ['task', action.payload.task_id, 'history_list'], $$data
      # TODO update task calc attr ?
    when ac.TD_UPDATE_TASK
      task_id = action.payload.task_id
      # check task already exist
      if $$o.getIn(['task', task_id])?
        # exist, only update raw
        $$data = Immutable.fromJS action.payload.data
        $$o = $$o.setIn ['task', task_id, raw], $$data
        # TODO update task calc attr ?
      else  # not exist, create a new task
        one_task = {
          raw: action.payload.data
          history: {}
          history_list: {}
        }
        $$data = Immutable.fromJS one_task
        $$o = $$o.setIn ['task', task_id], $$data
        # TODO update task calc attr ?
    when ac.TD_UPDATE_HISTORY
      $$data = Immutable.fromJS action.payload.data
      # task must exist
      $$o = $$o.setIn ['task', action.payload.task_id, 'history', action.payload.history_name], $$data
      # TODO update task calc attr ?
    #else: ignore
  $$o

module.exports = reducer
