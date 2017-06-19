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

btn = require '../sub/btn'


PageWebview = cC {
  _on_start_webview: ->
    # TODO get url ?
    # TODO process promise ?
    ssad_native.start_webview ''

  render: ->
    (cE View, {
      # TODO
      },
      (cE btn.BigPrimaryButton, {
        text: 'Start WebView'
        on_click: @_on_start_webview
        })
    )
    # TODO
}
PageWebview.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'SSAD WebView'
      header_props: props
      })
}

module.exports = PageWebview
