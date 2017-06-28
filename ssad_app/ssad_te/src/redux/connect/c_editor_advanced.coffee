# c_editor_advanced.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PEditorAdvanced = require '../../page/p_editor_advanced'
action = require '../action/a_editor_advanced'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PEditorAdvanced)
module.exports = O
