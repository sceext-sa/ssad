# a_main_menu.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

td = require '../../../td/td'

n_action = require '../nav/n_action'
a_common = require './a_common'
a_edit_create_task = require './a_edit_create_task'

# action types

MAIN_MENU_CREATE_TASK = 'main_menu_create_task'


create_task = ->
  (dispatch, getState) ->
    $$state = getState().main
    # check/set is_create_task
    if ! $$state.get('is_create_task')
      dispatch a_common.set_is_create_task(true)
      # reset edit
      dispatch a_edit_create_task.reset()
    # check task_id
    $$state = getState().main
    task_id = $$state.getIn ['edit_task', 'task_id']
    if ! task_id?
      # gen a new task_id
      task_id = await td.get_next_task_id()
      dispatch a_edit_create_task.set_task_id(task_id)
    # go to that page
    dispatch n_action.go 'page_edit_create_task'


module.exports = {
  MAIN_MENU_CREATE_TASK

  create_task  # thunk
}
