# r_editor_cm_scrollbar_style.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_editor_cm_scrollbar_style'


# $$o = state.main.editor
reducer = ($$o, action) ->
  switch action.type
    when ac.E_CM_SET_SCROLLBAR_STYLE
      $$o = $$o.set 'cm_scrollbar_style', action.payload
  $$o

module.exports = reducer
