# a_editor.coffee, ssad/ssad_app/ssad_te/src/redux/action/

core_editor = require '../../core_editor'


# action types

E_SET_SHOW_LINE_NUMBER = 'e_set_show_line_number'
E_SET_LINE_WRAP = 'e_set_line_wrap'


set_show_line_number = (enable) ->
  (dispatch, getState) ->
    c = core_editor.get_current_core()
    c.set_show_line_number enable

    dispatch {
      type: E_SET_SHOW_LINE_NUMBER
      payload: enable
    }
    await return

set_line_wrap = (enable) ->
  (dispatch, getState) ->
    c = core_editor.get_current_core()
    c.set_line_wrap enable

    dispatch {
      type: E_SET_LINE_WRAP
      payload: enable
    }
    await return

module.exports = {
  E_SET_SHOW_LINE_NUMBER
  E_SET_LINE_WRAP

  set_show_line_number  # thunk
  set_line_wrap  # thunk
}
