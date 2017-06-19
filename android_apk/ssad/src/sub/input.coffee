# input.coffee, ssad/android_apk/ssad/src/sub/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  StyleSheet
  View
  TextInput
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

Input = cC {
  _on_change: (text) ->
    @setState {
      value: text
    }
    @props.on_change?(text)

  getInitialState: ->
    {
      value: null
    }

  render: ->
    v = @state.value
    if ! v?
      v = @props.default_value
    if @props.value?
      v = @props.value

    ta = 'left'
    if @props.right
      ta = 'right'

    (cE TextInput, {
      style: [ss.input, {
        flex: 1
        padding: 5
        textAlign: ta
        fontSize: 15
        borderWidth: 1
        borderColor: co.text_sec
        borderRadius: 5
      } ]
      underlineColorAndroid: 'transparent'
      onChangeText: @_on_change
      value: v
      })
}

module.exports = Input
