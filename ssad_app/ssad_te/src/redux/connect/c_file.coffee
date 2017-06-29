# c_file.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

r_util = require '../r_util'
PFile = require '../../page/p_file'
action = require '../action/a_file'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    filename: r_util.get_filename $$state
    is_clean: $$state.get 'doc_clean'
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_open = ->
    dispatch action.open()
  o.on_save = ->
    dispatch action.save()
  o

O = connect(mapStateToProps, mapDispatchToProps)(PFile)
module.exports = O
