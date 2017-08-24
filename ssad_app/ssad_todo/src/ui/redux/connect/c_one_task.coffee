# c_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_one_task'
action = require '../action/a_one_task'


mapStateToProps = (state, props) ->
  $$state = state.main
  task_id = $$state.get 'task_id'
  data = null
  if task_id?
    data = state.td.getIn ['task', task_id]
    if data?
      data = data.toJS()
  {
    task_id
    data
    show_detail: $$state.get 'show_detail'
    history_list: []  # TODO
    can_load_more_history: false  # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_edit_task = ->
    dispatch action.edit_task()
  o.on_change_status = ->
    dispatch action.change_status()
  o.on_change_show_detail = (show) ->
    dispatch action.change_show_detail(show)
  o.on_load_more_history = ->
    # TODO
  o.on_hide_history = (history_name) ->
    # TODO
  o.on_show_history = () ->  # TODO
    # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
