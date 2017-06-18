# main.coffee, ssad/android_apk/ssad/src/page/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  StyleSheet
  View
  ScrollView
  Image
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

SubPageItem = require '../sub/sub_page_item'
NullFill = require '../sub/null_fill'
NavHeader = require '../sub/nav_header'


PageMain = cC {
  _on_page_server: ->
    @props.navigation.navigate 'page_server'
  _on_page_about: ->
    @props.navigation.navigate 'page_about'
  _on_page_setting: ->
    @props.navigation.navigate 'page_setting'

  render: ->
    (cE ScrollView, {
      style: ss.scroll
      contentContainerStyle: [ ss.box, ss.scroll_in ]
      },
      (cE SubPageItem, {
        text: 'ssad_server'
        on_click: @_on_page_server
        })
      # ssad logo
      (cE View, {
        style: {
          justifyContent: 'center'
          alignItems: 'center'
          backgroundColor: co.bg
          minHeight: 320
          flex: 1
        } },
        (cE Image, {
          style: {
            width: 256
            height: 256
          }
          source: require './ssad-1024.png'
          })
      )
      (cE SubPageItem, {
        text: 'About'
        on_click: @_on_page_about
        })
      (cE SubPageItem, {
        text: 'Settings'
        on_click: @_on_page_setting
        })
    )
}
PageMain.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'SSA Daemon'
      header_props: props
      main: true
      })
}

module.exports = PageMain
