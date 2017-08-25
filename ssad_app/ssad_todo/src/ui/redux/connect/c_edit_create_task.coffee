# c_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

task = require '../../../task/task'

Page = require '../../page/p_edit_create_task'
action = require '../action/a_edit_create_task'


mapStateToProps = (state, props) ->
  $$state = state.main
  $$td = state.td

  is_create_task = $$state.get 'is_create_task'
  # task_id
  task_id = $$state.getIn ['edit_task', 'task_id']
  # check task_data here
  task_data = $$state.get('edit_task').toJS()
  task_data_error = null
  enable_commit = true
  try
    task.check_task_data task_data
  catch e
    task_data_error = "#{e}"
    enable_commit = false
  task_check_form = task.check_form task_data
  # check task change, only for edit task
  if (! is_create_task) and enable_commit
    if task_id?
      old = $$td.getIn(['task', task_id]).toJS()
      enable_commit = false  # no commit, if task not change
      try
        task.check_task_change old, task_data
      catch e  # task changed  # TODO FIXME not use throw ?  (unsafe)
        enable_commit = true
    else
      enable_commit = false  # no task_id

  {
    is_create_task
    task_id
    task_data
    task_data_error
    enable_commit
    task_check_form
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
  o.edit_set_time_auto_ready = (text) ->
    dispatch action.set_time_auto_ready(text)
  o.edit_set_time_interval = (text) ->
    dispatch action.set_time_interval(text)
  o.edit_set_time_base = (base) ->
    dispatch action.set_time_base(base)
  o.edit_commit = ->
    dispatch action.commit()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
