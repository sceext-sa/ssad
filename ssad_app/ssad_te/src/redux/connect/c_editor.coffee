# c_editor.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PEditor = require '../../page/p_editor'
action = require '../action/a_editor'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    cm_scrollbar_style: $$state.getIn ['editor', 'cm_scrollbar_style']
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PEditor)
module.exports = O
