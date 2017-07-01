# c_editor_cm_scrollbar_style.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PEditorCmScrollbarStyle = require '../../page/p_editor_cm_scrollbar_style'
action = require '../action/a_editor_cm_scrollbar_style'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    cm_scrollbar_style: $$state.getIn ['editor', 'cm_scrollbar_style']
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_style = (style) ->
    dispatch action.set_scrollbar_style(style)
  o

O = connect(mapStateToProps, mapDispatchToProps)(PEditorCmScrollbarStyle)
module.exports = O
