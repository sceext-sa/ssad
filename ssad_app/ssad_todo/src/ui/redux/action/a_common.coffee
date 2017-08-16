# a_common.coffee, ssad/ssad_todo/src/ui/redux/action/

# action types

COMMON_UPDATE_INIT_PROGRESS = 'common_update_init_progress'
COMMON_SET_OP_DOING = 'common_set_op_doing'


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


module.exports = {
  COMMON_UPDATE_INIT_PROGRESS
  COMMON_SET_OP_DOING

  update_init_progress
  set_op_doing
}
