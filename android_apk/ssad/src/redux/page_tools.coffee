# page_tools.coffee, ssad/android_apk/ssad/src/redux/

{ connect } = require 'react-redux'

PageTools = require '../page/tools'
action = require './action/page_tools'


mapStateToProps = (state, props) ->
  $$state = state.page_tools
  {
    url: $$state.get 'url'
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # pass navigation
    navigation: props.navigation

    on_change_url: (text) ->
      dispatch action.change_url(text)
    on_start_webview: ->
      dispatch action.start_webview()
  }

O = connect(mapStateToProps, mapDispatchToProps)(PageTools)
module.exports = O
