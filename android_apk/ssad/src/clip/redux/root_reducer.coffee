# root_reducer.coffee, ssad/android_apk/ssad/src/clip/redux/

{ combineReducers } = require 'redux'

clip_list = require './reducer/clip_list'

root_reducer = combineReducers {
  clip_list
}
module.exports = root_reducer
