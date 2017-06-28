# c_file.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PFile = require '../../page/p_file'
action = require '../action/a_file'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PFile)
module.exports = O
