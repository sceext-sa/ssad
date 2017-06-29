# c_config_id_key.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PConfigIdKey = require '../../page/p_config_id_key'
action = require '../action/a_config_id_key'


mapStateToProps = (state, props) ->
  $$state = state.main
  app_id = $$state.getIn ['config', 'app_id']
  ssad_key = $$state.getIn ['config', 'ssad_key']
  if ! app_id?
    app_id = ''
  if ! ssad_key?
    ssad_key = ''
  error_info = $$state.getIn ['config', 'error']
  if error_info?
    error_info = error_info.toString()

  {
    app_id
    ssad_key
    error_info
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_change_id = (text) ->
    dispatch action.change_id(text)
  o.on_change_key = (text) ->
    dispatch action.change_key(text)
  o.on_ok = ->
    dispatch action.key_ok()
  o

O = connect(mapStateToProps, mapDispatchToProps)(PConfigIdKey)
module.exports = O
