# root_reducer.coffee, ssad/android_apk/ssad/src/redux/

{ combineReducers } = require 'redux'

main = require './reducer/main'
page_service = require './reducer/page_service'
page_tools = require './reducer/page_tools'
page_setting = require './reducer/page_setting'

root_reducer = combineReducers {
  main
  page_service
  page_tools
  page_setting
}
module.exports = root_reducer
