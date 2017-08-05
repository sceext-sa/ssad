# c_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_one_task'
action = require '../action/a_one_task'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
