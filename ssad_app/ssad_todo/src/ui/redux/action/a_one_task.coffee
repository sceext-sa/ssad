# a_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

config = require '../../../config'

n_action = require '../nav/n_action'
a_common = require './a_common'
a_edit_create_task = require './a_edit_create_task'
a_change_status = require './a_change_status'
a_task = require './a_task'
a_td = require './a_td'


# action types

OT_RESET = 'ot_reset'
OT_SET_TASK_ID = 'ot_set_task_id'
OT_UPDATE_HISTORY = 'ot_update_history'

OT_EDIT_TASK = 'ot_edit_task'
OT_CHANGE_STATUS = 'ot_change_status'
OT_CHANGE_SHOW_DETAIL = 'ot_change_show_detail'
OT_LOAD_MORE_HISTORY = 'ot_load_more_history'

OT_HIDE_HISTORY = 'ot_hide_history'
OT_SHOW_HISTORY = 'ot_show_history'
OT_HIDE_HISTORY_GROUP = 'ot_hide_history_group'
OT_SHOW_HISTORY_GROUP = 'ot_show_history_group'


reset = ->
  {
    type: OT_RESET
  }

set_task_id = (task_id) ->
  (dispatch, getState) ->
    # reset first
    dispatch reset()
    # new task_id
    dispatch {
      type: OT_SET_TASK_ID
      payload: task_id
    }
    # update data
    dispatch update_history(task_id)

update_history = (task_id) ->
  (dispatch, getState) ->
    $$task = getState().td.getIn ['task', task_id]
    dispatch {
      type: OT_UPDATE_HISTORY
      payload: {
        task_id
        task: $$task
      }
    }


_load_data = (data) ->
  (dispatch, getState) ->
    d = data.raw.data
    dispatch a_edit_create_task.set_type(d.type)
    dispatch a_edit_create_task.set_title(d.title)
    dispatch a_edit_create_task.set_desc(d.desc)
    # optional attr
    if d.time.planned_start?
      dispatch a_edit_create_task.set_time_planned_start(d.time.planned_start)
    if d.time.ddl?
      dispatch a_edit_create_task.set_time_ddl(d.time.ddl)
    if d.time.duration_limit?
      dispatch a_edit_create_task.set_time_duration_limit(d.time.duration_limit)
    if d.time.auto_ready?
      dispatch a_edit_create_task.set_time_auto_ready(d.time.auto_ready)
    if d.time.interval?
      dispatch a_edit_create_task.set_time_interval(d.time.interval)
    if d.time_base?
      dispatch a_edit_create_task.set_time_base(d.time_base)
    # load data done

edit_task = ->
  (dispatch, getState) ->
    dispatch {
      type: OT_EDIT_TASK
    }
    $$state = getState().main
    # check is edit this task
    is_create_task = $$state.get 'is_create_task'
    edit_task_id = $$state.getIn ['edit_task', 'task_id']
    task_id = $$state.getIn ['ot', 'task_id']
    # check task disabled
    if getState().td.getIn(['task', task_id, 'disabled'])
      return  # disabled task can not edit

    if is_create_task or (edit_task_id != task_id)
      # set is_create_task
      dispatch a_common.set_is_create_task(false)
      # reset task data
      dispatch a_edit_create_task.reset()
      # update task_id
      dispatch a_edit_create_task.set_task_id(task_id)
      # load data
      data = getState().td.getIn(['task', task_id]).toJS()
      dispatch _load_data(data)
    # go to that page
    dispatch n_action.go('page_edit_create_task')

change_status = ->
  (dispatch, getState) ->
    dispatch {
      type: OT_CHANGE_STATUS
    }
    $$state = getState().main
    # check task_id
    cs_task_id = $$state.getIn ['cs', 'task_id']
    task_id = $$state.getIn ['ot', 'task_id']
    if cs_task_id != task_id
      # reset first
      dispatch a_change_status.reset()
      # load data
      dispatch a_change_status.set_task_id(task_id)

      task = getState().td.getIn(['task', task_id]).toJS()
      dispatch a_change_status.set_status(task.status)
      dispatch a_change_status.set_disabled(task.disabled)
    # go to that page
    dispatch n_action.go('page_change_status')

change_show_detail = (show) ->
  {
    type: OT_CHANGE_SHOW_DETAIL
    payload: show
  }

load_more_history = (task_id) ->
  (dispatch, getState) ->
    dispatch {  # for DEBUG
      type: OT_LOAD_MORE_HISTORY
      payload: {
        task_id
      }
    }

    task = getState().td.getIn(['task', task_id]).toJS()
    all_history = Object.keys task.history_list
    to_load = []
    for i in all_history
      if ! task.history[i]?
        to_load.push i
    # sort history by time
    to_load.sort()
    to_load.reverse()  # latest items first

    # TODO show doing operate ?

    # load each history items
    for i in [0... config.LOAD_MORE_ONCE_N]
      if i >= to_load.length
        break

      await dispatch a_td.load_history(task_id, to_load[i])
    # load history done
    dispatch update_history(task_id)


hide_history = (task_id, history_name) ->
  (dispatch, getState) ->
    dispatch {  # for DEBUG
      type: OT_HIDE_HISTORY
      payload: {
        task_id
        history_name
      }
    }
    await dispatch a_task.hide_history(task_id, history_name)

    dispatch update_history(task_id)

show_history = (task_id, history_name) ->
  (dispatch, getState) ->
    dispatch {
      type: OT_SHOW_HISTORY
      payload: {
        task_id
        history_name
      }
    }
    await dispatch a_task.show_history(task_id, history_name)

    dispatch update_history(task_id)


hide_history_group = (task_id, group_id) ->
  (dispatch, getState) ->
    history_list = getState().td.getIn(['task', task_id, 'history_list']).toJS()
    dispatch {
      type: OT_HIDE_HISTORY_GROUP
      payload: {
        history_list
        group_id
      }
    }

show_history_group = (task_id, group_id) ->
  (dispatch, getState) ->
    history_list = getState().td.getIn(['task', task_id, 'history_list']).toJS()
    dispatch {
      type: OT_SHOW_HISTORY_GROUP
      payload: {
        history_list
        group_id
      }
    }


module.exports = {
  OT_RESET
  OT_SET_TASK_ID
  OT_UPDATE_HISTORY

  OT_EDIT_TASK
  OT_CHANGE_STATUS
  OT_CHANGE_SHOW_DETAIL
  OT_LOAD_MORE_HISTORY

  OT_HIDE_HISTORY
  OT_SHOW_HISTORY
  OT_HIDE_HISTORY_GROUP
  OT_SHOW_HISTORY_GROUP

  reset
  set_task_id  # thunk
  update_history  # thunk

  edit_task  # thunk
  change_status  # thunk
  change_show_detail
  load_more_history  # thunk

  hide_history  # thunk
  show_history  # thunk
  hide_history_group
  show_history_group
}
