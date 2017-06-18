# url_link.coffee, ssad/android_apk/ssad/src/sub/

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
  TouchableNativeFeedback
  Linking
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

UrlLink = cC {
  _on_click: ->
    Linking.openURL @props.url

  render: ->
    (cE TouchableNativeFeedback, {
      onPress: @_on_click
      background: TouchableNativeFeedback.Ripple co.bg_btn_touch
      },
      (cE View, {
        style: {
          alignSelf: 'stretch'
          backgroundColor: co.bg_sec
          padding: 5
        } },
        (cE Text, {
          style: {
            color: co.text_sec
            textDecorationLine: 'underline'
            fontSize: 15
          } },
          @props.url
        )
      )
    )
}

module.exports = UrlLink
