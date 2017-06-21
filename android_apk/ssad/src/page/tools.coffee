# tools.coffee, ssad/android_apk/ssad/src/page/

{
  createClass: cC
  createElement: cE
} = require 'react'
{ View } = require 'react-native'

ss = require '../style/ss'

NavHeader = require '../sub/nav_header'
FullScroll = require '../sub/full_scroll'
Title = require '../sub/title'
Input = require '../sub/input'

NotImplemented = require '../sub/not_implemented'

btn = require '../sub/btn'

PageTools = cC {
  # TODO support open url history ?

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE NavHeader, {
        title: 'Tools'
        navigation: @props.navigation
        })
      (cE FullScroll, null,
        # ssad webview
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 1
          } ]
          },
          (cE Title, {
            text: 'SSAD WebView'
            })
          # input url
          (cE View, {
            style: {
              flexDirection: 'row'
            } },
            (cE Input, {
              value: @props.url
              on_change: @props.on_change_url
              })
          )
          # TODO open url history ?
          (cE NotImplemented)
        )
        (cE btn.BigPrimaryButton, {
          text: 'New WebView'
          no_margin: true
          on_click: @props.on_start_webview
          })
      )
    )
}
PageTools.navigationOptions = {
  header: null
}

module.exports = PageTools
