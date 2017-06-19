# webview.coffee, ssad/android_apk/ssad/src/page/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  StyleSheet
  View
  Text
} = require 'react-native'

ss = require '../style/ss'
ssad_native = require '../ssad_native'

NavHeader = require '../sub/nav_header'
Input = require '../sub/input'
NullFill = require '../sub/null_fill'

btn = require '../sub/btn'


PageWebview = cC {
  _on_start_webview: ->
    # TODO error process
    await ssad_native.start_webview @state.url

  _on_change_url: (text) ->
    @setState {
      url: text
    }

  getInitialState: ->
    {
      url: 'http://html5test.com'
    }

  componentDidMount: ->
    url = await ssad_native.get_webview_url()
    if url?
      @setState {
        url
      }

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE View, {
        style: {
          flexDirection: 'row'
        } },
        (cE Input, {
          value: @state.url
          on_change: @_on_change_url
          })
      )
      (cE NullFill)
      (cE btn.BigPrimaryButton, {
        text: 'New WebView'
        no_margin: true
        on_click: @_on_start_webview
        })
    )
}
PageWebview.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'SSAD WebView'
      header_props: props
      })
}

module.exports = PageWebview
