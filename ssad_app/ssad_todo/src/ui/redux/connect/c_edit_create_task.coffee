# c_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_edit_create_task'
action = require '../action/a_edit_create_task'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    is_create_task: $$state.get 'is_create_task'
    task_data: $$state.get('edit_task').toJS()
    enable_commit: true  # TODO support check task data ?
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.edit_reset = ->
    dispatch action.reset()
  o.edit_set_type = (type) ->
    dispatch action.set_type(type)
  o.edit_set_title = (text) ->
    dispatch action.set_title(text)
  o.edit_set_desc = (text) ->
    dispatch action.set_desc(text)
  o.edit_set_time_planned_start = (text) ->
    dispatch action.set_time_planned_start(text)
  o.edit_set_time_ddl = (text) ->
    dispatch action.set_time_ddl(text)
  o.edit_set_time_duration_limit = (text) ->
    dispatch action.set_time_duration_limit(text)
  o.edit_set_time_interval = (text) ->
    dispatch action.set_time_interval(text)
  o.edit_set_time_base = (base) ->
    dispatch action.set_time_base(base)
  o.edit_commit = ->
    dispatch action.commit()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
