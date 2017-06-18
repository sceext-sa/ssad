# not_implemented.coffee, ssad/android_apk/ssad/src/sub/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  View
  Text
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

NotImplemented = cC {
  render: ->
    (cE View, {
      style: [ss.box, {
        flex: 1
        justifyContent: 'center'
        alignItems: 'center'
      }]
      },
      (cE Text, {
        style: [ss.text_sec, {
            textAlign: 'center'
          }]
        },
        'Not implemented'
      )
    )
}

module.exports = NotImplemented
