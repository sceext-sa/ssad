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

get_webview_url = ->
  await _n.get_webview_url()


module.exports = {
  version

  start_webview  # async
  get_webview_url  # async
}
