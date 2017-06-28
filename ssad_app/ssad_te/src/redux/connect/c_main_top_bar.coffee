# c_main_top_bar.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

MainTopBar = require '../../main_top_bar'
action = require '../action/a_main_top_bar'
a_nav = require '../nav/n_action'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  {
    on_nav: (id) ->
      dispatch a_nav.go(id)
  }

O = connect(mapStateToProps, mapDispatchToProps)(MainTopBar)
module.exports = O
