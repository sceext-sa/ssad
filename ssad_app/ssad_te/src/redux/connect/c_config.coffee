# c_config.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PConfig = require '../../page/p_config'
action = require '../action/a_config'
r_util = require '../r_util'


mapStateToProps = (state, props) ->
  $$state = state.main
  key_error = false
  if $$state.getIn(['config', 'error'])?
    key_error = true

  {
    core_editor: $$state.getIn ['config', 'core_editor']
    need_config_key: r_util.check_key $$state
    key_error
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PConfig)
module.exports = O
