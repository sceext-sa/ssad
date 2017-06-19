# main.coffee, ssad/android_apk/ssad/src/

{ createStore } = require 'redux'
Immutable = require 'immutable'

# TODO
React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{ AppRegistry } = require 'react-native'
{ StackNavigator } = require 'react-navigation'

SsadWebview = require './ssad_webview'

ss = require './style/ss'

PageMain = require './page/main'
PageServer = require './page/server'
PageClip = require './page/clip'
PageWebview = require './page/webview'
PageAbout = require './page/about'
PageSetting = require './page/setting'

# use react-navigation
Main = StackNavigator {
  page_main: { screen: PageMain }
  page_server: { screen: PageServer }
  page_clip: { screen: PageClip }
  page_webview: { screen: PageWebview }
  page_about: { screen: PageAbout }
  page_setting: { screen: PageSetting }
}, {
  headerMode: 'screen'  # 'float', 'screen'
  cardStyle: ss.box
}


AppRegistry.registerComponent 'ssad', () ->
  Main
AppRegistry.registerComponent 'ssad_webview', () ->
  SsadWebview
module.exports = Main
