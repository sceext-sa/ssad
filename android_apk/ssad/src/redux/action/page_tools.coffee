# page_tools.coffee, ssad/android_apk/ssad/src/redux/action/

ssad_native = require '../../ssad_native'

# action types

PAGE_TOOLS_CHANGE_URL = 'page_tools_change_url'
PAGE_TOOLS_START_WEBVIEW = 'page_tools_start_webview'

change_url: (text) ->
  {
    type: PAGE_TOOLS_CHANGE_URL
    payload: text
  }

start_webview: ->
  (dispatch, getState) ->
    dispatch {
      type: PAGE_TOOLS_START_WEBVIEW
    }
    $$page_tools = getState().page_tools
    url = $$page_tools.get 'url'
    # start webview
    await ssad_native.start_webview url

module.exports = {
  PAGE_TOOLS_CHANGE_URL
  PAGE_TOOLS_START_WEBVIEW

  change_url
  start_webview  # thunk
}
