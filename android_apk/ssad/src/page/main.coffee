# main.coffee, ssad/android_apk/ssad/src/page/

{
  createClass: cC
  createElement: cE
} = require 'react'

{
  View
  Image
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

NavHeader = require '../sub/nav_header'
FullScroll = require '../sub/full_scroll'
SubPageItem = require '../sub/sub_page_item'


PageMain = cC {
  _on_page: (page_name) ->
    @props.navigation.navigate page_name

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE NavHeader, {
        title: 'SSA Daemon'
        main: true
        navigation: @props.navigation
        })
      (cE FullScroll, null,
        (cE SubPageItem, {
          text: 'Services'
          on_click: ->
            @_on_page 'page_service'
          })
        (cE SubPageItem, {
          text: 'Tools'
          on_click: ->
            @_on_page 'page_tools'
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
          on_click: ->
            @_on_page 'page_about'
          })
        (cE SubPageItem, {
          text: 'Settings'
          on_click: ->
            @_on_page 'page_setting'
          })
      )
    )
}
PageMain.navigationOptions = {
  header: null
}

module.exports = PageMain
