# a_task_info.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

# action types

TI_LOAD_TASKS = 'ti_load_tasks'
TI_LOAD_HISTORIES = 'ti_load_histories'
TI_SET_HISTORY_HIDE = 'ti_set_history_hide'
TI_UPDATE_ENABLE_LIST = 'ti_update_enable_list'
TI_UPDATE_DISABLED_LIST = 'ti_update_disabled_list'
TI_RESET = 'ti_reset'


load_tasks = (tasks) ->
  {
    type: TI_LOAD_TASKS
    payload: tasks
  }

load_histories = (task_id, histories) ->
  {
    type: TI_LOAD_HISTORIES
    payload: {
      task_id
      data: histories
    }
  }

set_history_hide = (task_id, history_name, hide) ->
  {
    type: TI_SET_HISTORY_HIDE
    payload: {
      task_id
      history_name
      hide
    }
  }

update_enable_list = (data) ->
  {
    type: TI_UPDATE_ENABLE_LIST
    payload: data
  }

update_disabled_list = (data) ->
  {
    type: TI_UPDATE_DISABLED_LIST
    payload: data
  }

reset = ->
  {
    type: TI_RESET
  }

module.exports = {
  TI_LOAD_TASKS
  TI_LOAD_HISTORIES
  TI_SET_HISTORY_HIDE
  TI_UPDATE_ENABLE_LIST
  TI_UPDATE_DISABLED_LIST
  TI_RESET

  load_tasks
  load_histories
  set_history_hide
  update_enable_list
  update_disabled_list
  reset
}
