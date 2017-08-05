# c_main_menu.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_main_menu'
action = require '../action/a_main_menu'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
