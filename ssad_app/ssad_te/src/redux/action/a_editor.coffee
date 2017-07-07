# a_editor.coffee, ssad/ssad_app/ssad_te/src/redux/action/

core_editor = require '../../core_editor'


# action types

E_SET_SHOW_LINE_NUMBER = 'e_set_show_line_number'
E_SET_LINE_WRAP = 'e_set_line_wrap'
E_SET_READ_ONLY = 'e_set_read_only'
E_SET_TAB_SIZE = 'e_set_tab_size'
E_SET_OVERWRITE = 'e_set_overwrite'
E_SET_SHOW_INVISIBLES = 'e_set_show_invisibles'
E_SET_ACE_SCROLL_PAST_END = 'e_set_ace_scroll_past_end'


set_show_line_number = (enable) ->
  (dispatch, getState) ->
    core_editor.set_show_line_number enable

    dispatch {
      type: E_SET_SHOW_LINE_NUMBER
      payload: enable
    }
    await return

set_line_wrap = (enable) ->
  (dispatch, getState) ->
    core_editor.set_line_wrap enable

    dispatch {
      type: E_SET_LINE_WRAP
      payload: enable
    }
    await return

set_read_only = (enable) ->
  (dispatch, getState) ->
    core_editor.set_read_only enable

    dispatch {
      type: E_SET_READ_ONLY
      payload: enable
    }
    await return

set_tab_size = (size) ->
  (dispatch, getState) ->
    core_editor.set_tab_size size

    dispatch {
      type: E_SET_TAB_SIZE
      payload: size
    }
    await return

set_overwrite = (enable) ->
  (dispatch, getState) ->
    core_editor.set_overwrite enable

    dispatch {
      type: E_SET_OVERWRITE
      payload: enable
    }
    await return

set_show_invisibles = (enable) ->
  (dispatch, getState) ->
    core_editor.set_show_invisibles enable

    dispatch {
      type: E_SET_SHOW_INVISIBLES
      payload: enable
    }
    await return

set_ace_scroll_past_end = (enable) ->
  (dispatch, getState) ->
    core_editor.ace_set_scroll_past_end enable

    dispatch {
      type: E_SET_ACE_SCROLL_PAST_END
      payload: enable
    }
    await return

module.exports = {
  E_SET_SHOW_LINE_NUMBER
  E_SET_LINE_WRAP
  E_SET_READ_ONLY
  E_SET_TAB_SIZE
  E_SET_OVERWRITE
  E_SET_SHOW_INVISIBLES
  E_SET_ACE_SCROLL_PAST_END

  set_show_line_number  # thunk
  set_line_wrap  # thunk
  set_read_only  # thunk
  set_tab_size  # thunk
  set_overwrite  # thunk
  set_show_invisibles # thunk

  set_ace_scroll_past_end  # thunk
}
