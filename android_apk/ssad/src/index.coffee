# index.coffee, ssad/android_apk/ssad/src/

{ AppRegistry } = require 'react-native'

Main = require './main'
SsadWebview = require './ssad_webview'
SsadClip = require './clip/ssad_clip'


AppRegistry.registerComponent 'ssad', () ->
  Main
AppRegistry.registerComponent 'ssad_webview', () ->
  SsadVewview
AppRegistry.registerComponent 'ssad_clip', () ->
  SsadClip
module.exports = Main
