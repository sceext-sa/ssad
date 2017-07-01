# r_editor.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_editor'
# sub reducers
r_editor_cm_scrollbar_style = require './r_editor_cm_scrollbar_style'


# $$o = state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.E_SET_SHOW_LINE_NUMBER
      $$o = $$o.setIn ['editor', 'show_line_number'], action.payload
    when ac.E_SET_LINE_WRAP
      $$o = $$o.setIn ['editor', 'line_wrap'], action.payload
    else
      # call sub reducers
      $$o = $$o.update 'editor', ($$editor) ->
        r_editor_cm_scrollbar_style $$editor, action
  $$o

module.exports = reducer
