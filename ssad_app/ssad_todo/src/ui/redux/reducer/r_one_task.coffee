# r_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

task = require '../../../task/task'

state = require '../state'
ac = require '../action/a_one_task'


_update_history = ($$o, task_id, $$task) ->
  # check is this task
  if task_id != $$o.getIn(['ot', 'task_id'])
    return $$o

  history_list = $$task.get('history_list').toJS()
  loaded_history = Object.keys $$task.get('history').toJS()
  # check each loaded history
  for history_name in loaded_history
    if ! history_list[history_name]  # history is not hide
      $$o = $$o.setIn ['ot', 'history', history_name], false  # not enable hide_show
    else  # history is hide
      if ! $$o.getIn(['ot', 'history', history_name])?
        # no record, set to false (hide) by default
        $$o = $$o.setIn ['ot', 'history', history_name], false
      # else: record unchanged
  # clean history (group)
  { history } = task.make_group history_list, $$o.getIn(['ot', 'history']).toJS()
  $$o = $$o.setIn ['ot', 'history'], Immutable.fromJS(history)
  $$o

_set_group_hide_show = ($$o, history_list, group_id, show) ->
  history = $$o.getIn(['ot', 'history']).toJS()

  { group } = task.make_group history_list, history
  # set a whole group
  for history_name in group[group_id].history
    history[history_name] = show
  $$o = $$o.setIn ['ot', 'history'], Immutable.fromJS(history)
  $$o

# $$o: state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.OT_RESET
      $$o = $$o.set 'ot', Immutable.fromJS(state.main.ot)
    when ac.OT_SET_TASK_ID
      $$o = $$o.setIn ['ot', 'task_id'], action.payload
    when ac.OT_UPDATE_HISTORY
      $$o = _update_history $$o, action.payload.task_id, action.payload.task

    when ac.OT_CHANGE_SHOW_DETAIL
      $$o = $$o.set 'show_detail', action.payload

    when ac.OT_HIDE_HISTORY_GROUP
      $$o = _set_group_hide_show $$o, action.payload.history_list, action.payload.group_id, false
    when ac.OT_SHOW_HISTORY_GROUP
      $$o = _set_group_hide_show $$o, action.payload.history_list, action.payload.group_id, true
    # else: ignore
  $$o

module.exports = reducer
