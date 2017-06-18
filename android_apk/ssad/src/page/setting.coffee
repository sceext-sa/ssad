# setting.coffee, ssad/android_apk/ssad/src/page/

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


PageSetting = cC {
  render: ->
    (cE NotImplemented)
}
PageSetting.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'Settings'
      header_props: props
      })
}

module.exports = PageSetting
