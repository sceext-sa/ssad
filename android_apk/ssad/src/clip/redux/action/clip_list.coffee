# clip_list.coffee, ssad/android_apk/ssad/src/clip/redux/action/

ssad_native = require '../../../ssad_native'
util = require '../../../util'

# action types

CLIP_ENTER_EDIT_MODE = 'clip_enter_edit_mode'
CLIP_EXIT_EDIT_MODE = 'clip_exit_edit_mode'
CLIP_SELECT_ITEM = 'clip_select_item'
CLIP_REMOVE = 'clip_remove'
CLIP_SET_CLIP = 'clip_set_clip'

CLIP_INIT = 'clip_init'
CLIP_CHANGED = 'clip_changed'
CLIP_REFRESH = 'clip_refresh'


init = ->
  (dispatch, getState) ->
    dispatch {
      type: CLIP_INIT
    }
    # get clip list
    data = await ssad_native.get_clip()
    dispatch changed(data)

changed = (data) ->
  {
    type: CLIP_CHANGED
    payload: data
  }

refresh = ->
  (dispatch, getState) ->
    dispatch {
      type: CLIP_REFRESH
    }
    # TODO
    await return

enter_edit_mode = ->
  {
    type: CLIP_ENTER_CLIP_MODE
  }

exit_edit_mode = ->
  {
    type: CLIP_EXIT_CLIP_MODE
  }

select_item = (index) ->
  {
    type: CLIP_SELECT_ITEM
    payload: index
  }

remove = ->
  (dispatch, getState) ->
    dispatch {
      type: CLIP_REMOVE
    }
    # TODO save in java ?
    await return

set_clip = (index) ->
  (dispatch, getState) ->
    dispatch {
      type: CLIP_SET_CLIP
      payload: index
    }
    # TODO set clip ?
    # TODO finish activity ?

module.exports = {
  CLIP_ENTER_EDIT_MODE
  CLIP_EXIT_EDIT_MODE
  CLIP_SELECT_ITEM
  CLIP_REMOVE
  CLIP_SET_CLIP
  CLIP_INIT
  CLIP_CHANGED
  CLIP_REFRESH

  init  # thunk
  changed
  refresh  # thunk

  enter_edit_mode
  exit_edit_mode
  select_item
  remove  # thunk
  set_clip  # thunk
}
