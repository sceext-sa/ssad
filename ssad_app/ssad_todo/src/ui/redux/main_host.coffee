# main_host.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/

{ connect } = require 'react-redux'

Main = require '../main'
action = require './action/a_common'


mapStateToProps = (state, props) ->
  $$state = state.main
  $$i = $$state.get 'init_load_progress'
  {
    init_load_task_done: $$i.get 'done'
    init_load_task_now: $$i.get 'now'
    init_load_task_all: $$i.get 'all'

    op_doing: $$state.get 'op_doing'
    init_load_error: $$i.get 'error'
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # TODO
  }

O = connect(mapStateToProps, mapDispatchToProps)(Main)
module.exports = O
