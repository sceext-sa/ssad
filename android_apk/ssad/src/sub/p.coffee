# p.coffee, ssad/android_apk/ssad/src/sub/

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

P = cC {
  render: ->
    (cE View, {
      style: {
        alignSelf: 'stretch'
        margin: 10
      } },
      # TODO text line-wrap ?
      (cE Text, {
        style: {
          color: co.text
          fontSize: 15
        } },
        @props.text
      )
    )
}

module.exports = P
