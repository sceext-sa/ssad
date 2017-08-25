# a_td.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

td = require '../../../td/td'


# action types

TD_LOAD_NEXT_TASK_ID = 'td_load_next_task_id'
TD_LOAD_TASK_LIST = 'td_load_task_list'
TD_LOAD_DISABLED_LIST = 'td_load_disabled_list'
TD_LOAD_HISTORY_LIST = 'td_load_history_list'
TD_LOAD_TASK = 'td_load_task'
TD_LOAD_HISTORY = 'td_load_history'

TD_UPDATE_NEXT_TASK_ID = 'td_update_next_task_id'
TD_UPDATE_TASK_LIST = 'td_update_task_list'
TD_UPDATE_DISABLED_LIST = 'td_update_disabled_list'
TD_UPDATE_HISTORY_LIST = 'td_update_history_list'
TD_UPDATE_TASK = 'td_update_task'
TD_UPDATE_HISTORY = 'td_update_history'

TD_SET_NO_CALC = 'td_set_no_calc'
TD_CALC_ALL = 'td_calc_all'


# TODO error process ?

load_next_task_id = (ignore_error) ->
  (dispatch, getState) ->
    dispatch {  # start mark
      type: TD_LOAD_NEXT_TASK_ID
      payload: {
        ignore_error
      }
    }
    task_id = await td.get_next_task_id ignore_error
    dispatch update_next_task_id(task_id)

load_task_list = ->
  (dispatch, getState) ->
    dispatch {
      type: TD_LOAD_TASK_LIST
    }
    data = await td.get_task_list()
    dispatch update_task_list(data)

load_disabled_list = ->
  (dispatch, getState) ->
    dispatch {
      type: TD_LOAD_DISABLED_LIST
    }
    data = await td.get_disabled_list()
    dispatch update_disabled_list(data)

load_history_list = (task_id) ->
  (dispatch, getState) ->
    dispatch {
      type: TD_LOAD_HISTORY_LIST
      payload: {
        task_id
      }
    }
    data = await td.get_history_list task_id
    dispatch update_history_list(task_id, data)

load_task = (task_name) ->
  (dispatch, getState) ->
    dispatch {
      type: TD_LOAD_TASK
      payload: {
        task_name
      }
    }
    data = await td.load_task task_name
    dispatch update_task(data.data.task_id, data)

load_history = (task_id, history_name) ->
  (dispatch, getState) ->
    dispatch {
      type: TD_LOAD_HISTORY
      payload: {
        task_id
        history_name
      }
    }
    data = await td.load_history task_id, history_name
    dispatch update_history(task_id, history_name, data)


update_next_task_id = (id) ->
  {
    type: TD_UPDATE_NEXT_TASK_ID
    payload: id
  }

update_task_list = (data) ->
  {
    type: TD_UPDATE_TASK_LIST
    payload: data
  }

update_disabled_list = (data) ->
  {
    type: TD_UPDATE_DISABLED_LIST
    payload: data
  }

update_history_list = (task_id, data) ->
  {
    type: TD_UPDATE_HISTORY_LIST
    payload: {
      task_id
      data
    }
  }

update_task = (task_id, data) ->
  {
    type: TD_UPDATE_TASK
    payload: {
      task_id
      data
    }
  }

update_history = (task_id, history_name, data) ->
  {
    type: TD_UPDATE_HISTORY
    payload: {
      task_id
      history_name
      data
    }
  }


set_no_calc = (no_calc) ->
  {
    type: TD_SET_NO_CALC
    payload: no_calc
  }

calc_all = ->
  {
    type: TD_CALC_ALL
  }


module.exports = {
  TD_LOAD_NEXT_TASK_ID
  TD_LOAD_TASK_LIST
  TD_LOAD_DISABLED_LIST
  TD_LOAD_HISTORY_LIST
  TD_LOAD_TASK
  TD_LOAD_HISTORY

  TD_UPDATE_NEXT_TASK_ID
  TD_UPDATE_TASK_LIST
  TD_UPDATE_DISABLED_LIST
  TD_UPDATE_HISTORY_LIST
  TD_UPDATE_TASK
  TD_UPDATE_HISTORY

  TD_SET_NO_CALC
  TD_CALC_ALL

  load_next_task_id  # thunk
  load_task_list  # thunk
  load_disabled_list  # thunk
  load_history_list  # thunk
  load_task  # thunk
  load_history  # thunk

  update_next_task_id
  update_task_list
  update_disabled_list
  update_history_list
  update_task
  update_history

  set_no_calc
  calc_all
}
