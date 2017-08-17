# a_common.coffee, ssad/ssad_todo/src/ui/redux/action/

# action types

COMMON_UPDATE_INIT_PROGRESS = 'common_update_init_progress'
COMMON_SET_OP_DOING = 'common_set_op_doing'
COMMON_SET_TASK_ID = 'common_set_task_id'
COMMON_SET_IS_CREATE_TASK = 'common_set_is_create_task'


update_init_progress = (data) ->
  {
    type: COMMON_UPDATE_INIT_PROGRESS
    payload: data
  }

set_op_doing = (doing) ->
  {
    type: COMMON_SET_OP_DOING
    payload: doing
  }

set_task_id = (id) ->
  {
    type: COMMON_SET_TASK_ID
    payload: id
  }

set_is_create_task = (i) ->
  {
    type: COMMON_SET_IS_CREATE_TASK
    payload: i
  }


module.exports = {
  COMMON_UPDATE_INIT_PROGRESS
  COMMON_SET_OP_DOING
  COMMON_SET_TASK_ID
  COMMON_SET_IS_CREATE_TASK

  update_init_progress
  set_op_doing
  set_task_id
  set_is_create_task
}
