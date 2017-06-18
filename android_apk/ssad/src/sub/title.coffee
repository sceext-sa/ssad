# title.coffee, ssad/android_apk/ssad/src/sub/

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

Title = cC {
  render: ->
    (cE View, {
      style: {
        alignSelf: 'stretch'
        marginTop: 10
        marginBottom: 10
      } },
      (cE Text, {
        style: [ ss.title, ss.title_size ]
        },
        @props.text
      )
    )
}

module.exports = Title
