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

ss = require './style/ss'

PageMain = require './page/main'
PageAbout = require './page/about'
PageServer = require './page/server'
PageSetting = require './page/setting'

# use react-navigation
Main = StackNavigator {
  page_main: { screen: PageMain }
  page_about: { screen: PageAbout }
  page_server: { screen: PageServer }
  page_setting: { screen: PageSetting }
}, {
  headerMode: 'screen'  # 'float', 'screen'
  cardStyle: ss.box
}


AppRegistry.registerComponent 'ssad', () ->
  Main
module.exports = Main
