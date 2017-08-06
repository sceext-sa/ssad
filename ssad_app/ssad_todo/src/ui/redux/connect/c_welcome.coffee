# c_welcome.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_welcome'
action = require '../action/a_welcome'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    app_id: $$state.getIn ['wel', 'app_id']
    ssad_key: $$state.getIn ['wel', 'ssad_key']
    error: $$state.getIn ['wel', 'error']
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_change_id = (text) ->
    dispatch action.change_id(text)
  o.on_change_key = (text) ->
    dispatch action.change_key(text)
  o.on_ok = ->
    dispatch action.check_key()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
