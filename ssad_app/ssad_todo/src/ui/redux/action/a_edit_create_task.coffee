# a_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

task = require '../../../task/task'
n_action = require '../nav/n_action'
a_task = require './a_task'

# action types

ET_RESET = 'et_reset'
ET_SET_TYPE = 'et_set_type'
ET_SET_TITLE = 'et_set_title'
ET_SET_DESC = 'et_set_desc'
ET_SET_TIME_PLANNED_START = 'et_set_time_planned_start'
ET_SET_TIME_DDL = 'et_set_time_ddl'
ET_SET_TIME_DURATION_LIMIT = 'et_set_time_duration_limit'
ET_SET_TIME_AUTO_READY = 'et_set_time_auto_ready'
ET_SET_TIME_INTERVAL = 'et_set_time_interval'
ET_SET_TIME_BASE = 'et_set_time_base'
ET_COMMIT = 'et_commit'


reset = ->
  {
    type: ET_RESET
  }

set_type = (type) ->
  {
    type: ET_SET_TYPE
    payload: type
  }

set_title = (text) ->
  {
    type: ET_SET_TITLE
    payload: text
  }

set_desc = (text) ->
  {
    type: ET_SET_DESC
    payload: text
  }

set_time_planned_start = (text) ->
  {
    type: ET_SET_TIME_PLANNED_START
    payload: text
  }

set_time_ddl = (text) ->
  {
    type: ET_SET_TIME_DDL
    payload: text
  }

set_time_duration_limit = (text) ->
  {
    type: ET_SET_TIME_DURATION_LIMIT
    payload: text
  }

set_time_auto_ready = (text) ->
  {
    type: ET_SET_TIME_AUTO_READY
    payload: text
  }

set_time_interval = (text) ->
  {
    type: ET_SET_TIME_INTERVAL
    payload: text
  }

set_time_base = (base) ->
  {
    type: ET_SET_TIME_BASE
    payload: base
  }

commit = ->
  (dispatch, getState) ->
    dispatch {  # for DEBUG
      type: ET_COMMIT
    }

    $$state = getState().main
    # check create / edit task
    is_create_task = $$state.get 'is_create_task'
    if is_create_task
      # create task
      # TODO show/hide doing_operate ?
      # TODO error process
      task_data = $$state.get('edit_task').toJS()
      # check task data again (just before create it)
      task.check_task_data task_data
      # check task_id
      task_id = getState().td.get 'next_task_id'
      task.check_task_id task_id  # throw

      await dispatch a_task.create_task(task_data)
      # page: go back
      dispatch n_action.back()
      # reset after create task success
      dispatch reset()
    else
      # TODO update task
      console.log "WARNING: a_edit_create_task.commit: update task not finished !"


module.exports = {
  ET_RESET
  ET_SET_TYPE
  ET_SET_TITLE
  ET_SET_DESC
  ET_SET_TIME_PLANNED_START
  ET_SET_TIME_DDL
  ET_SET_TIME_DURATION_LIMIT
  ET_SET_TIME_AUTO_READY
  ET_SET_TIME_INTERVAL
  ET_SET_TIME_BASE
  ET_COMMIT

  reset
  set_type
  set_title
  set_desc
  set_time_planned_start
  set_time_ddl
  set_time_duration_limit
  set_time_auto_ready
  set_time_interval
  set_time_base
  commit  # thunk
}
