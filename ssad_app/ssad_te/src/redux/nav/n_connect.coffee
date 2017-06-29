# n_connect.coffee, ssad/ssad_app/ssad_te/src/redux/nav/

{ connect } = require 'react-redux'

Nav = require '../../sub/nav'
action = require './n_action'
tree = require './tree'


mapStateToProps = (state, props) ->
  $$state = state.nav
  {
    pos: tree.get_pos $$state
  }

mapDispatchToProps = (dispatch, props) ->
  {
    on_back: ->
      dispatch action.back()
    on_nav: (id) ->
      dispatch action.go(id)
  }

O = connect(mapStateToProps, mapDispatchToProps)(Nav)
module.exports = O
