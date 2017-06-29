# c_main.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

r_util = require '../r_util'
PMain = require '../../page/p_main'
action = require '../action/a_main'


mapStateToProps = (state, props) ->
  $$state = state.main
  filename = r_util.get_filename $$state
  if filename?
    filename = $$state.get 'filename'

  {
    filename
    need_config_key: r_util.check_key $$state
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PMain)
module.exports = O
