# r_editor.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_editor'
# sub reducers
r_editor_cm_scrollbar_style = require './r_editor_cm_scrollbar_style'


# $$o = state.main
reducer = ($$o, action) ->
  #switch action.type
  # else
  # call sub reducers
  $$o = $$o.update 'editor', ($$editor) ->
    r_editor_cm_scrollbar_style $$editor, action
  $$o

module.exports = reducer
