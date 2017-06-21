# util.coffee, ssad/android_apk/ssad/src/

{
  ToastAndroid
  AsyncStorage
} = require 'react-native'


# show a text toast
toast = (text) ->
  ToastAndroid.show text, ToastAndroid.SHORT


# load/save config for page_service
SSAD_CONFIG = 'ssad_config'

load_config = ->
  try
    data = await AsyncStorage.getItem SSAD_CONFIG
    return JSON.parse data
  catch e
    # TODO more error info ?
    toast "error load config"

save_config = (data) ->
  try
    await AsyncStorage.setItem SSAD_CONFIG, JSON.stringify(data)
  catch e
    # TODO more error info ?
    toast "error save config"


module.exports = {
  toast

  load_config  # async
  save_config  # async
}
