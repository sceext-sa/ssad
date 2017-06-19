# sub_page_item.coffee, ssad/android_apk/ssad/src/sub/

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
  # out box
  box: {
    backgroundColor: co.bg_btn
    borderWidth: 0
    borderTopWidth: 0.5
    borderBottomWidth: 0.5
    borderColor: co.bg
  }
  # in box
  in: {
    flexDirection: 'row'
    alignItems: 'center'
    padding: 10
  }
  # text
  text: {
    color: co.text_btn
    flex: 1
    fontSize: 15
    paddingTop: 5
  }
  # right mark
  right: {
    color: co.text_sec
    paddingLeft: 5
    fontSize: 20
    textAlign: 'center'
  }
}

SubPageItem = cC {
  _on_click: ->
    @props.on_click?()

  render: ->
    (cE View, {
      style: s.box
      },
      (cE TouchableNativeFeedback, {
        onPress: @_on_click
        background: TouchableNativeFeedback.Ripple co.bg_btn_touch
        },
        (cE View, {
          style: s.in
          },
          (cE Text, {
            style: s.text
            },
            @props.text
          )
          (cE Text, {
            style: s.right
            },
            '>'
          )
        )
      )
    )
}

module.exports = SubPageItem
