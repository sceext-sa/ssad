# c_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

task = require '../../../task/task'

Page = require '../../page/p_one_task'
action = require '../action/a_one_task'


mapStateToProps = (state, props) ->
  $$state = state.main
  task_id = $$state.getIn ['ot', 'task_id']
  data = null
  group = []  # history of groups to show
  can_load_more_history = false
  if task_id?
    data = state.td.getIn ['task', task_id]
    if data?
      data = data.toJS()
      # make group
      history = $$state.getIn(['ot', 'history']).toJS()
      { group } = task.make_group data.history_list, history
      # TODO can_load_more_history

  {
    task_id
    data
    show_detail: $$state.get 'show_detail'
    can_load_more_history

    group
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props

  o.on_edit_task = ->
    dispatch action.edit_task()
  o.on_change_status = ->
    dispatch action.change_status()
  o.on_change_show_detail = (show) ->
    dispatch action.change_show_detail(show)

  o.on_load_more_history = (task_id) ->
    dispatch action.load_more_history(task_id)

  o.on_hide_history = (task_id, history_name) ->
    dispatch action.hide_history(task_id, history_name)
  o.on_show_history = (task_id, history_name) ->
    dispatch action.show_history(task_id, history_name)
  o.on_hide_history_group = (task_id, group_id) ->
    dispatch action.hide_history_group(task_id, group_id)
  o.on_show_history_group = (task_id, group_id) ->
    dispatch action.show_history_group(task_id, group_id)
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
