# c_config_core.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PConfigCore = require '../../page/p_config_core'
action = require '../action/a_config_core'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PConfigCore)
module.exports = O
