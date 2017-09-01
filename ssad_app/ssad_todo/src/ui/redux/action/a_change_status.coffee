# a_change_status.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

n_action = require '../nav/n_action'
a_task = require './a_task'


# fix `require` cycle
_update_history = (task_id) ->
  a_one_task = require './a_one_task'
  a_one_task.update_history(task_id)

# action types

CS_SET_TASK_ID = 'cs_set_task_id'
CS_SET_STATUS = 'cs_set_status'
CS_SET_DISABLED = 'cs_set_disabled'
CS_SET_COMMENT = 'cs_set_comment'
CS_RESET = 'cs_reset'

CS_COMMIT_STATUS = 'cs_commit_status'
CS_COMMIT_DISABLED = 'cs_commit_disabled'
CS_ADD_COMMENT = 'cs_add_comment'


set_task_id = (task_id) ->
  {
    type: CS_SET_TASK_ID
    payload: task_id
  }

set_status = (status) ->
  {
    type: CS_SET_STATUS
    payload: status
  }

set_disabled = (disabled) ->
  {
    type: CS_SET_DISABLED
    payload: disabled
  }

set_comment = (text) ->
  {
    type: CS_SET_COMMENT
    payload: text
  }

reset = ->
  {
    type: CS_RESET
  }


commit_status = ->
  (dispatch, getState) ->
    dispatch {
      type: CS_COMMIT_STATUS
    }
    $$state = getState().main
    task_id = $$state.getIn ['cs', 'task_id']
    status = $$state.getIn ['cs', 'status']
    # check status changed
    old_status = getState().td.getIn ['task', task_id, 'calc', 'status']
    if status == old_status
      return

    await dispatch a_task.change_status(task_id, status)
    # reset after OK
    dispatch reset()
    # update one_task
    dispatch _update_history(task_id)
    # nav back
    dispatch n_action.back()

commit_disabled = ->
  (dispatch, getState) ->
    dispatch {
      type: CS_COMMIT_DISABLED
    }
    $$state = getState().main
    task_id = $$state.getIn ['cs', 'task_id']
    disabled = $$state.getIn ['cs', 'disabled']
    old_disabled = getState().td.getIn ['task', task_id, 'calc', 'disabled']
    if disabled == old_disabled
      return  # not changed

    if disabled
      await dispatch a_task.disable_task(task_id)
    else
      await dispatch a_task.enable_task(task_id)
    # reset after OK
    dispatch reset()
    dispatch _update_history(task_id)
    dispatch n_action.back()

add_comment = ->
  (dispatch, getState) ->
    dispatch {
      type: CS_ADD_COMMENT
    }
    $$state = getState().main
    task_id = $$state.getIn ['cs', 'task_id']
    comment = $$state.getIn ['cs', 'comment']
    if comment.trim() is ''
      return  # not add empty comment

    await dispatch a_task.add_comment(task_id, comment)
    # reset after OK
    dispatch reset()
    dispatch _update_history(task_id)
    dispatch n_action.back()


module.exports = {
  CS_SET_TASK_ID
  CS_SET_STATUS
  CS_SET_DISABLED
  CS_SET_COMMENT
  CS_RESET

  CS_COMMIT_STATUS
  CS_COMMIT_DISABLED
  CS_ADD_COMMENT

  set_task_id
  set_status
  set_disabled
  set_comment
  reset

  commit_status  # thunk
  commit_disabled  # thunk
  add_comment  # thunk
}
