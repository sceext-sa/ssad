# about.coffee, ssad/android_apk/ssad/src/page/

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


PageAbout = cC {
  render: ->
    (cE NotImplemented)
}
PageAbout.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'About'
      header_props: props
      })
}

module.exports = PageAbout
