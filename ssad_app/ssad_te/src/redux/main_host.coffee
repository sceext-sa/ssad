# main_host.coffee, ssad/ssad_app/ssad_te/src/redux/

{ connect } = require 'react-redux'

Main = require '../main'
action = require './action/a_common'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # TODO
  }

O = connect(mapStateToProps, mapDispatchToProps)(Main)
module.exports = O
