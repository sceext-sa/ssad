# ssad_native.coffee, ssad/android_apk/ssad/src/

{
  NativeModules
} = require 'react-native'
_n = NativeModules.ssad_native


version = ->
  JSON.parse _n.VERSION_INFO

start_webview = (url) ->
  opt = {
    url: url
  }
  await _n.start_webview JSON.stringify(opt)

# TODO

module.exports = {
  version

  start_webview  # async
}
