# text_area.coffee, ssad/android_apk/ssad/src/sub/

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
co = require '../style/color'

TextArea = cC {
  render: ->
    (cE View, {
      style: {
        alignSelf: 'stretch'
        margin: 5
        padding: 5
        backgroundColor: co.bg_sec
      } },
      # TODO text line-wrap ?
      (cE Text, {
        style: [ ss.text_size, ss.text_sec ]
        selectable: @props.selectable
        },
        @props.text
      )
    )
}

module.exports = TextArea
