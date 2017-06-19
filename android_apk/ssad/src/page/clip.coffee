# clip.coffee, ssad/android_apk/ssad/src/page/

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

NavHeader = require '../sub/nav_header'
NotImplemented = require '../sub/not_implemented'


PageClip = cC {
  render: ->
    (cE NotImplemented)
}
PageClip.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'SSAD Clip'
      header_props: props
      })
}

module.exports = PageClip
