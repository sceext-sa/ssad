# c_file_select.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PFileSelect = require '../../page/p_file_select'
action = require '../action/a_file_select'
r_util = require '../r_util'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    need_config_key: r_util.check_key $$state
    app_id: $$state.get 'app_id'
    ssad_key: $$state.get 'ssad_key'
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_load_dir = (data) ->
    dispatch action.load_dir(data)
  o.on_select_file = (data) ->
    dispatch action.select_file(data)
  o.on_error = (error) ->
    dispatch action.select_error(error)
  o

O = connect(mapStateToProps, mapDispatchToProps)(PFileSelect)
module.exports = O
