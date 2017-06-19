# nav_header.coffee, ssad/android_apk/ssad/src/sub/

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
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

s = StyleSheet.create {
  # container
  box: {
    flexDirection: 'row'
    alignItems: 'center'
    height: 50
    backgroundColor: co.bg_nav
  }
  # title
  title: {
    flex: 1
    fontWeight: 'bold'
    fontSize: 20
    color: co.title
  }
  # main title
  main: {
    textAlign: 'center'
  }
  # goback button
  back: {
    color: co.text_sec
    fontWeight: '100'
    fontSize: 20
    paddingLeft: 20
    paddingRight: 20
  }
}

NavHeader = cC {
  _on_goback: ->
    @props.header_props.navigation.goBack()

  render: ->
    if @props.main
      (cE View, {
        style: s.box
        },
        (cE Text, {
          style: [ s.title, s.main ]
          },
          @props.title
        )
      )
    else
      (cE View, {
        style: s.box
        },
        (cE TouchableNativeFeedback, {
          onPress: @_on_goback
          background: TouchableNativeFeedback.Ripple co.bg_btn_touch
          },
          (cE View, {
            style: {
              alignSelf: 'stretch'
              flexDirection: 'row'
              alignItems: 'center'
            } },
            (cE Text, {
              style: s.back
              },
              '<'
            )
          )
        )
        (cE Text, {
          style: s.title
          },
          @props.title
        )
      )
}

module.exports = NavHeader
