# null_fill.coffee, ssad/android_apk/ssad/src/sub/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  View
} = require 'react-native'

NullFill = cC {
  render: ->
    (cE View, {
      style: {
        flex: 1
      } }
    )
}

module.exports = NullFill
