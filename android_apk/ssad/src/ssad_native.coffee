# ssad_native.coffee, ssad/android_apk/ssad/src/

{
  NativeModules
} = require 'react-native'


version = ->
  JSON.parse NativeModules.ssad_native.VERSION_INFO

# TODO

module.exports = {
  version
}
