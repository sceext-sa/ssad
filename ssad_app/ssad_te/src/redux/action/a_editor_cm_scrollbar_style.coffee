# a_editor_cm_scrollbar_style.coffee, ssad/ssad_app/ssad_te/src/redux/action/

core_editor = require '../../core_editor'


# action types

E_CM_SET_SCROLLBAR_STYLE = 'e_cm_set_scrollbar_style'


set_scrollbar_style = (style) ->
  (dispatch, getState) ->
    # set to core editor
    c = core_editor.get_current_core()
    c.set_scrollbar_style style

    dispatch {
      type: E_CM_SET_SCROLLBAR_STYLE
      payload: style
    }
    await return

module.exports = {
  E_CM_SET_SCROLLBAR_STYLE

  set_scrollbar_style  # thunk
}
