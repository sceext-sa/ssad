# c_main_top_bar.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

MainTopBar = require '../../main_top_bar'
action = require '../action/a_main_top_bar'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # TODO
  }

O = connect(mapStateToProps, mapDispatchToProps)(MainTopBar)
module.exports = O
