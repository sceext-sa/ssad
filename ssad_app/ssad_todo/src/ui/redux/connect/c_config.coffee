# c_config.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_config'
action = require '../action/a_config'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    init_load_time_s: $$state.getIn ['config', 'init_load_time_s']
    init_load_thread_n: $$state.getIn ['config', 'init_load_thread_n']
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_init_load_thread_n = (text) ->
    dispatch action.set_init_load_thread_n(text)
  o.on_save_init_load_thread_n = ->
    dispatch action.save_init_load_thread_n()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
