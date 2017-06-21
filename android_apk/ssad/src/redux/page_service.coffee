# page_service.coffee, ssad/android_apk/ssad/src/redux/

{ connect } = require 'react-redux'

PageService = require '../page/service'
action = require './action/page_service'


mapStateToProps = (state, props) ->
  $$state = state.page_service
  port = $$state.get 'server_port'
  if ! port?
    port = '(unknow)'
  {
    is_server_runnig: $$state.get 'is_server_running'
    is_clip_running: $$state.get 'is_clip_running'
    disable_server_button: $$state.get 'disable_server_button'
    disable_clip_button: $$state.get 'disable_clip_button'
    server_port: port
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # pass navigation
    navigation: props.navigation

    on_start_server: ->
      dispatch action.start_server()
    on_start_clip: ->
      dispatch action.start_clip()
    on_stop_server: ->
      dispatch action.stop_server()
    on_stop_clip: ->
      dispatch action.stop_clip()
  }

O = connect(mapStateToProps, mapDispatchToProps)(PageService)
module.exports = O
