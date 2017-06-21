# main.coffee, ssad/android_apk/ssad/src/redux/action/

ssad_native = require '../../ssad_native'
action_page_service = require './page_service'

# action types

MAIN_INIT = 'main_init'
MAIN_SERVICE_CHANGED = 'main_service_changed'


init = ->
  (dispatch, getState) ->
    dispatch {
      type: MAIN_INIT
    }
    # get service status
    dispatch service_changed()
    await return

service_changed = ->
  (dispatch, getState) ->
    # get new service status
    status = await ssad_native.status()

    dispatch {
      type: MAIN_SERVICE_CHANGED
      payload: status
    }
    # update page_service
    dispatch action_page_service.service_changed(status)

module.exports = {
  MAIN_INIT
  MAIN_SERVICE_CHANGED

  init  # thunk
  service_changed  # thunk
}
