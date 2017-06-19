# hr.coffee, ssad/android_apk/ssad/src/sub/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  View
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

Hr = cC {
  render: ->
    mb = 10
    mt = 10
    if @props.marginBottom?
      mb = @props.marginBottom
    if @props.marginTop?
      mt = @props.marginTop

    (cE View, {
      style: {
        borderWidth: 0
        borderTopWidth: 1
        borderColor: co.bg_btn
        marginTop: mt
        marginBottom: mb
      } }
    )
}

module.exports = Hr
