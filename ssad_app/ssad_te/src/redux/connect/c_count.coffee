# c_count.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PCount = require '../../page/p_count'
action = require '../action/a_count'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PCount)
module.exports = O
