# full_scroll.coffee, ssad/android_apk/ssad/src/sub/

{
  createClass: cC
  createElement: cE
} = require 'react'
{
  View
  ScrollView
} = require 'react-native'

ss = require '../style/ss'

FullScroll = cC {
  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE ScrollView, {
        style: ss.scroll
        contentContainerStyle: [ ss.box, ss.scroll_in ]
        },
        (cE View, {
          style: {
            flex: 1
          } },
          @props.children
        )
      )
    )
}

module.exports = FullScroll
