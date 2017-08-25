# c_change_status.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_change_status'
action = require '../action/a_change_status'


mapStateToProps = (state, props) ->
  $$state = state.main
  task_id = $$state.getIn ['cs', 'task_id']
  task_title = ''
  old_status = ''
  old_disabled = true
  if task_id?
    task = state.td.getIn(['task', task_id]).toJS()
    task_title = task.raw.data.title
    old_status = task.status
    old_disabled = task.disabled

  {
    task_id
    task_title

    comment: $$state.getIn ['cs', 'comment']

    status: $$state.getIn ['cs', 'status']
    disabled: $$state.getIn ['cs', 'disabled']
    old_status
    old_disabled
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_status = (status) ->
    dispatch action.set_status(status)
  o.on_set_disabled = (disabled) ->
    dispatch action.set_disabled(disabled)
  o.on_set_comment = (text) ->
    dispatch action.set_comment(text)
  o.commit_status = ->
    dispatch action.commit_status()
  o.commit_disabled = ->
    dispatch action.commit_disabled()
  o.add_comment = ->
    dispatch action.add_comment()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
