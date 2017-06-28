# c_file_select.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PFileSelect = require '../../page/p_file_select'
action = require '../action/a_file_select'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  o = props  # pass all props
  # TODO
  o

O = connect(mapStateToProps, mapDispatchToProps)(PFileSelect)
module.exports = O
