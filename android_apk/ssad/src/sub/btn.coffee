# btn.coffee, ssad/android_apk/ssad/src/sub/

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
  no_margin: {
    alignSelf: 'stretch'
    padding: 10
    height: 50
  }
  no_margin_small: {
    padding: 10
    paddingLeft: 20
    paddingRight: 20
  }
  big_btn: {
    alignSelf: 'stretch'
    padding: 5
    margin: 5
  }
  btn: {
    padding: 5
    paddingLeft: 15
    paddingRight: 15
    margin: 5
    borderRadius: 5
  }
}

# base button
BaseButton = cC {
  _on_click: ->
    @props.on_click?()

  render: ->
    if @props.disabled
      (cE View, {
        style: [ @props.btn_style, {
          backgroundColor: co.bg_btn
        } ]
        },
        (cE Text, {
          style: [ ss.btn, ss.btn_disabled ]
          },
          @props.text
        )
      )
    else
      (cE TouchableNativeFeedback, {
        onPress: @_on_click
        background: TouchableNativeFeedback.Ripple co.bg_btn_touch
        },
        (cE View, {
          style: [ @props.btn_style, {
            backgroundColor: @props.btn_bg
          } ]
          },
          (cE Text, {
            style: [ ss.btn, @props.text_style ]
            },
            @props.text
          )
        )
      )
}


# normal big button
BigButton = cC {
  render: ->
    (cE BaseButton, {
      on_click: @props.on_click
      text: @props.text
      disabled: @props.disabled

      btn_style: s.big_btn
      btn_bg: co.bg_btn
      text_style: ss.btn_n
      })
}

# big primary button
BigPrimaryButton = cC {
  render: ->
    bs = s.big_btn
    if @props.no_margin
      bs = s.no_margin
    (cE BaseButton, {
      on_click: @props.on_click
      text: @props.text
      disabled: @props.disabled

      btn_style: bs
      btn_bg: co.bg_btn_p
      text_style: ss.btn_p
      })
}

# big danger button
BigDangerButton = cC {
  render: ->
    bs = s.big_btn
    if @props.no_margin
      bs = s.no_margin
    (cE BaseButton, {
      on_click: @props.on_click
      text: @props.text
      disabled: @props.disabled

      btn_style: bs
      btn_bg: co.bg_btn_danger
      text_style: ss.btn_danger
      })
}

# normal (small) button
Button = cC {
  render: ->
    bs = s.btn
    if @props.no_margin
      bs = s.no_margin_small
    (cE BaseButton, {
      on_click: @props.on_click
      text: @props.text
      disabled: @props.disabled

      btn_style: bs
      btn_bg: co.bg_btn
      text_style: ss.btn_n
      })
}

# small primary button
PrimaryButton = cC {
  render: ->
    (cE BaseButton, {
      on_click: @props.on_click
      text: @props.text
      disabled: @props.disabled

      btn_style: s.btn
      btn_bg: co.bg_btn_p
      text_style: ss.btn_p
      })
}

# small danger button
DangerButton = cC {
  render: ->
    (cE BaseButton, {
      on_click: @props.on_click
      text: @props.text
      disabled: @props.disabled

      btn_style: s.btn
      btn_bg: co.bg_btn_danger
      text_style: ss.btn_danger
      })
}

module.exports = {
  BigButton
  BigPrimaryButton
  BigDangerButton

  Button
  PrimaryButton
  DangerButton
}
