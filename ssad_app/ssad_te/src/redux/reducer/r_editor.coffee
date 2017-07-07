# r_editor.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_editor'
# sub reducers
r_editor_cm_scrollbar_style = require './r_editor_cm_scrollbar_style'


# $$o = state.main
reducer = ($$o, action) ->
  core_editor = $$o.getIn ['config', 'core_editor']
  switch action.type
    when ac.E_SET_SHOW_LINE_NUMBER
      $$o = $$o.setIn ['editor', core_editor, 'show_line_number'], action.payload
    when ac.E_SET_LINE_WRAP
      $$o = $$o.setIn ['editor', core_editor, 'line_wrap'], action.payload
    when ac.E_SET_READ_ONLY
      $$o = $$o.setIn ['editor', core_editor, 'read_only'], action.payload
    when ac.E_SET_TAB_SIZE
      $$o = $$o.setIn ['editor', core_editor, 'tab_size'], action.payload
    when ac.E_SET_OVERWRITE
      $$o = $$o.setIn ['editor', core_editor, 'overwrite'], action.payload
    when ac.E_SET_SHOW_INVISIBLES
      $$o = $$o.setIn ['editor', core_editor, 'show_invisibles'], action.payload
    when ac.E_SET_ACE_SCROLL_PAST_END
      $$o = $$o.setIn ['editor', 'ACE', 'ace_scroll_past_end'], action.payload
    else
      # call sub reducers
      $$o = $$o.updateIn ['editor', 'codemirror'], ($$editor) ->
        r_editor_cm_scrollbar_style $$editor, action
  $$o

module.exports = reducer
