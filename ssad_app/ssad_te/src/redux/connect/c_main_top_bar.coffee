# c_main_top_bar.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

MainTopBar = require '../../main_top_bar'
action = require '../action/a_main_top_bar'
a_nav = require '../nav/n_action'
r_util = require '../r_util'
a_file = require '../action/a_file'


mapStateToProps = (state, props) ->
  $$state = state.main
  filename = r_util.get_filename $$state
  if filename?
    filename = $$state.get 'filename'

  {
    filename
    is_clean: $$state.get 'doc_clean'
  }

mapDispatchToProps = (dispatch, props) ->
  {
    on_save: ->
      dispatch a_file.save()
    on_nav: (id) ->
      dispatch a_nav.go(id)
  }

O = connect(mapStateToProps, mapDispatchToProps)(MainTopBar)
module.exports = O
