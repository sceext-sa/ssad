# c_file_auto_save.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PFileAutoSave = require '../../page/p_file_auto_save'
action = require '../action/a_file_auto_save'

mapStateToProps = (state, props) ->
  $$state = state.main
  log_text = $$state.getIn(['auto_save', 'logs']).join('\n') + '\n'
  {
    enable: $$state.getIn ['auto_save', 'enable']
    log_text
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_enable = (enable) ->
    dispatch action.set_enable(enable)
  o

O = connect(mapStateToProps, mapDispatchToProps)(PFileAutoSave)
module.exports = O
