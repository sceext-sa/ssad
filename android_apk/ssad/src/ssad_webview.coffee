# ssad_webview.coffee, ssad/android_apk/ssad/src/

{
  createClass: cC
  createElement: cE
} = require 'react'
{
  View
  WebView
} = require 'react-native'

ss = require './style/ss'
ssad_native = require './ssad_native'


SsadWebview = cC {
  getInitialState: ->
    {
      url: null
    }

  componentDidMount: ->
    url = await ssad_native.get_webview_url()
    if url?
      @setState {
        url
      }

  render: ->
    if @state.url?
      (cE WebView, {
        style: {
          flex: 1
          }
        source: {
          uri: @state.url
          }
        })
    else
      (cE View, {
        style: [ ss.box, {
          flex: 1
        } ]
        })
}

module.exports = SsadWebview
