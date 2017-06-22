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


_get_clip_list = (dispatch) ->
  data = await ssad_native.get_clip()
  dispatch changed(data)

_make_save_data = ($$state) ->
  raw = $$state.get('raw_data').toJS()
  data = $$state.get('data').toJS()
  index = $$state.get 'index'

  raw.index = -1
  list = []
  for i in [0... data.length]
    # current clip item can not be removed
    if (! data[i].selected) || (i == index)
      list.push raw.list[i]
    # check current clip item
    if i == index
      # update index
      raw.index = raw.list.length - 1
  raw.list = list
  raw

init = ->
  (dispatch, getState) ->
    dispatch {
      type: CLIP_INIT
    }
    await _get_clip_list dispatch

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
    await _get_clip_list dispatch

enter_edit_mode = ->
  {
    type: CLIP_ENTER_EDIT_MODE
  }

exit_edit_mode = ->
  {
    type: CLIP_EXIT_EDIT_MODE
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
    $$state = getState().clip_list
    data = _make_save_data $$state
    # save to java side
    await ssad_native.set_clip data
    # update after remove
    await _get_clip_list dispatch

set_clip = (index) ->
  (dispatch, getState) ->
    dispatch {
      type: CLIP_SET_CLIP
      payload: index
    }
    # get text
    $$state = getState().clip_list
    text = $$state.getIn ['data', index, 'text']
    # TODO maybe just use react-native API ? (not java)
    # set to primary clip
    await ssad_native.set_primary_clip text

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
