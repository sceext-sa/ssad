# a_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

n_action = require '../nav/n_action'
a_one_task = require './a_one_task'

# action types

ETL_CHANGE_LIST = 'etl_change_list'
ETL_SET_TASK_ID = 'etl_set_task_id'
ETL_SHOW_ITEM = 'etl_show_item'


change_list = (name) ->
  {
    type: ETL_CHANGE_LIST
    payload: name
  }

set_task_id = (task_id) ->
  {
    type: ETL_SET_TASK_ID
    payload: task_id
  }

show_item = (task_id) ->
  (dispatch, getState) ->
    dispatch set_task_id(task_id)
    # update one_task page
    dispatch a_one_task.set_task_id(task_id)
    # go to `page_one_task`
    dispatch n_action.go('page_one_task')

module.exports = {
  ETL_CHANGE_LIST
  ETL_SET_TASK_ID
  ETL_SHOW_ITEM

  change_list
  set_task_id

  show_item  # thunk
}
