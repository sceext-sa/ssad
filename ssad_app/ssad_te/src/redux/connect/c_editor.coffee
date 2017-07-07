# c_editor.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PEditor = require '../../page/p_editor'
action = require '../action/a_editor'


mapStateToProps = (state, props) ->
  $$state = state.main
  core_editor = $$state.getIn ['config', 'core_editor']
  {
    show_line_number: $$state.getIn ['editor', core_editor, 'show_line_number']
    line_wrap: $$state.getIn ['editor', core_editor, 'line_wrap']
    read_only: $$state.getIn ['editor', core_editor, 'read_only']
    tab_size: $$state.getIn ['editor', core_editor, 'tab_size']
    overwrite: $$state.getIn ['editor', core_editor, 'overwrite']
    show_invisibles: $$state.getIn ['editor', core_editor, 'show_invisibles']
    core_editor

    cm_scrollbar_style: $$state.getIn ['editor', 'codemirror', 'cm_scrollbar_style']
    ace_scroll_past_end: $$state.getIn ['editor', 'ACE', 'ace_scroll_past_end']
    ace_cursor_style: $$state.getIn ['editor', 'ACE', 'ace_cursor_style']
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_show_line_number = (enable) ->
    dispatch action.set_show_line_number(enable)
  o.on_set_line_wrap = (enable) ->
    dispatch action.set_line_wrap(enable)
  o.on_set_read_only = (enable) ->
    dispatch action.set_read_only(enable)
  o.on_set_tab_size = (size) ->
    dispatch action.set_tab_size(size)
  o.on_set_overwrite = (enable) ->
    dispatch action.set_overwrite(enable)
  o.on_set_show_invisibles = (enable) ->
    dispatch action.set_show_invisibles(enable)
  o.on_set_ace_scroll_past_end = (enable) ->
    dispatch action.set_ace_scroll_past_end(enable)
  o

O = connect(mapStateToProps, mapDispatchToProps)(PEditor)
module.exports = O
