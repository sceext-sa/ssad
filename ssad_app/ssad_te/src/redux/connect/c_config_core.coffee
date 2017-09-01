# c_config_core.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PConfigCore = require '../../page/p_config_core'
action = require '../action/a_config_core'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    core_editor: $$state.getIn ['config', 'core_editor']
    doc_clean: $$state.get 'doc_clean'
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_core = (core_name) ->
    dispatch action.set_core(core_name)
  o

O = connect(mapStateToProps, mapDispatchToProps)(PConfigCore)
module.exports = O
