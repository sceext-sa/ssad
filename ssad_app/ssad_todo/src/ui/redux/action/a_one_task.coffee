# a_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

n_action = require '../nav/n_action'
a_common = require './a_common'
a_edit_create_task = require './a_edit_create_task'
a_change_status = require './a_change_status'


# action types

OT_EDIT_TASK = 'ot_edit_task'
OT_CHANGE_STATUS = 'ot_change_status'
OT_CHANGE_SHOW_DETAIL = 'ot_change_show_detail'
OT_LOAD_MORE_HISTORY = 'ot_load_more_history'
OT_HIDE_HISTORY = 'ot_hide_history'
OT_SHOW_HISTORY = 'ot_show_history'  # TODO

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
    task_id = $$state.get 'task_id'
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
    task_id = $$state.get 'task_id'
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

load_more_history = ->
  (dispatch, getState) ->
    # TODO
    await return

hide_history = (history_name) ->
  (dispatch, getState) ->
    # TODO
    await return

show_history = () ->  # TODO
  (dispatch, getState) ->
    # TODO
    await return

module.exports = {
  OT_EDIT_TASK
  OT_CHANGE_STATUS
  OT_CHANGE_SHOW_DETAIL
  OT_LOAD_MORE_HISTORY
  OT_HIDE_HISTORY
  OT_SHOW_HISTORY

  edit_task  # thunk
  change_status  # thunk
  change_show_detail

  load_more_history  # thunk
  hide_history  # thunk
  show_history  # thunk
}
