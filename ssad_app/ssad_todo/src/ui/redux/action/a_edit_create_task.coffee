# a_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

task = require '../../../task/task'
n_action = require '../nav/n_action'

# action types

EDIT_TASK_RESET = 'edit_task_reset'
EDIT_TASK_SET_TASK_ID = 'edit_task_set_task_id'
EDIT_TASK_SET_TYPE = 'edit_task_set_type'
EDIT_TASK_SET_TITLE = 'edit_task_set_title'
EDIT_TASK_SET_DESC = 'edit_task_set_desc'
EDIT_TASK_SET_TIME_PLANNED_START = 'edit_task_set_time_planned_start'
EDIT_TASK_SET_TIME_DDL = 'edit_task_set_time_ddl'
EDIT_TASK_SET_TIME_DURATION_LIMIT = 'edit_task_set_time_duration_limit'
EDIT_TASK_SET_TIME_INTERVAL = 'edit_task_set_time_interval'
EDIT_TASK_SET_TIME_BASE = 'edit_task_set_time_base'
EDIT_TASK_COMMIT = 'edit_task_commit'


reset = ->
  {
    type: EDIT_TASK_RESET
  }

set_task_id = (id) ->
  {
    type: EDIT_TASK_SET_TASK_ID
    payload: id
  }

set_type = (type) ->
  {
    type: EDIT_TASK_SET_TYPE
    payload: type
  }

set_title = (text) ->
  {
    type: EDIT_TASK_SET_TITLE
    payload: text
  }

set_desc = (text) ->
  {
    type: EDIT_TASK_SET_DESC
    payload: text
  }

set_time_planned_start = (text) ->
  {
    type: EDIT_TASK_SET_TIME_PLANNED_START
    payload: text
  }

set_time_ddl = (text) ->
  {
    type: EDIT_TASK_SET_TIME_DDL
    payload: text
  }

set_time_duration_limit = (text) ->
  {
    type: EDIT_TASK_SET_TIME_DURATION_LIMIT
    payload: text
  }

set_time_interval = (text) ->
  {
    type: EDIT_TASK_SET_TIME_INTERVAL
    payload: text
  }

set_time_base = (base) ->
  {
    type: EDIT_TASK_SET_TIME_BASE
    payload: base
  }

commit = ->
  (dispatch, getState) ->
    $$state = getState().main
    # check create / edit task
    is_create_task = $$state.get 'is_create_task'
    if is_create_task
      # create task
      # TODO show/hide doing_operate ?
      # TODO error process
      task_data = $$state.get('edit_task').toJS()

      await task.create_task task_data
      # page: go back
      dispatch n_action.back()
      # reset after create task success
      dispatch reset()
    else
      # TODO update task
      console.log "WARNING: a_edit_create_task.commit: update task not finished !"


module.exports = {
  EDIT_TASK_RESET
  EDIT_TASK_SET_TASK_ID
  EDIT_TASK_SET_TYPE
  EDIT_TASK_SET_TITLE
  EDIT_TASK_SET_DESC
  EDIT_TASK_SET_TIME_PLANNED_START
  EDIT_TASK_SET_TIME_DDL
  EDIT_TASK_SET_TIME_DURATION_LIMIT
  EDIT_TASK_SET_TIME_INTERVAL
  EDIT_TASK_SET_TIME_BASE
  EDIT_TASK_COMMIT

  reset
  set_task_id
  set_type
  set_title
  set_desc
  set_time_planned_start
  set_time_ddl
  set_time_duration_limit
  set_time_interval
  set_time_base
  commit  # thunk
}
