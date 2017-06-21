# page_tools.coffee, ssad/android_apk/ssad/src/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/page_tools'

_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.page_tools
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.PAGE_TOOLS_CHANGE_URL
      $$o = $$o.set 'url', action.payload
    #when ac.PAGE_TOOLS_START_WEBVIEW
  $$o

module.exports = reducer
