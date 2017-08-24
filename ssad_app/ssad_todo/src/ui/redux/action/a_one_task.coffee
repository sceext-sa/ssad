# a_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/


# action types

OT_EDIT_TASK = 'ot_edit_task'
OT_CHANGE_STATUS = 'ot_change_status'
OT_CHANGE_SHOW_DETAIL = 'ot_change_show_detail'
OT_LOAD_MORE_HISTORY = 'ot_load_more_history'
OT_HIDE_HISTORY = 'ot_hide_history'
OT_SHOW_HISTORY = 'ot_show_history'  # TODO

edit_task = ->
  (dispatch, getState) ->
    dispatch {
      type: OT_EDIT_TASK
    }
    # TODO
    await return

change_status = ->
  (dispatch, getState) ->
    dispatch {
      type: OT_CHANGE_STATUS
    }
    # TODO
    await return

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
