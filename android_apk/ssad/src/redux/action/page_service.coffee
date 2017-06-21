# page_service.coffee, ssad/android_apk/ssad/src/redux/action/

ssad_native = require '../../ssad_native'
util = require '../../util'

# action types

PAGE_SERVICE_START_SERVER = 'page_service_start_server'
PAGE_SERVICE_START_CLIP = 'page_service_start_clip'
PAGE_SERVICE_STOP_SERVER = 'page_service_stop_server'
PAGE_SERVICE_STOP_CLIP = 'page_service_stop_clip'
PAGE_SERVICE_CHANGED = 'page_service_changed'
PAGE_SERVICE_ENABLE_SERVER_BUTTON = 'page_service_enable_server_button'


start_server = ->
  (dispatch, getState) ->
    dispatch {
      type: PAGE_SERVICE_START_SERVER
    }
    $$config = getState().page_setting.get 'config'
    port = $$config.get 'port'
    root_key = $$config.get 'root_key'
    # check port and root_key
    if (Number.isNaN port) || (port < 1000) || (port > 65534)
      util.toast "Error: bad port #{port}"
      return dispatch enable_server_button()
    if ! root_key?
      util.toast "Error: root_key is empty !"
      return dispatch enable_server_button()
    await ssad_native.start_server port, root_key

start_clip = ->
  (dispatch, getState) ->
    dispatch {
      type: PAGE_SERVICE_START_CLIP
    }
    await ssad_native.start_clip()

stop_server = ->
  (dispatch, getState) ->
    dispatch {
      type: PAGE_SERVICE_STOP_SERVER
    }
    await ssad_native.stop_server()

stop_clip = ->
  (dispatch, getState) ->
    dispatch {
      type: PAGE_SERVICE_STOP_CLIP
    }
    await ssad_native.stop_clip()

service_changed = (status) ->
  {
    type: PAGE_SERVICE_CHANGED
    payload: status
  }

enable_server_button = ->
  {
    type: PAGE_SERVICE_ENABLE_SERVER_BUTTON
  }


module.exports = {
  PAGE_SERVICE_START_SERVER
  PAGE_SERVICE_START_CLIP
  PAGE_SERVICE_STOP_SERVER
  PAGE_SERVICE_STOP_CLIP
  PAGE_SERVICE_CHANGED
  PAGE_SERVICE_ENABLE_SERVER_BUTTON

  start_server  # thunk
  start_clip  # thunk
  stop_server  # thunk
  stop_clip  # thunk

  service_changed
  enable_server_button
}
