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
  o = Object.assign {}, props  # pass all props
  o.on_create_task = ->
    dispatch action.create_task()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
