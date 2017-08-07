# a_welcome.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

util = require '../../../util'
ssad_server_api = require '../../../ssad_server_api'
n_action = require '../nav/n_action'

# action types

WELCOME_CHANGE_ID = 'welcome_change_id'
WELCOME_CHANGE_KEY = 'welcome_change_key'
WELCOME_CHECK_KEY = 'welcome_check_key'
WELCOME_KEY_OK = 'welcome_key_ok'
WELCOME_KEY_ERR = 'welcome_key_err'

change_id = (text) ->
  {
    type: WELCOME_CHANGE_ID
    payload: text
  }

change_key = (text) ->
  {
    type: WELCOME_CHANGE_KEY
    payload: text
  }

check_key = ->
  (dispatch, getState) ->
    dispatch {
      type: WELCOME_CHECK_KEY
    }
    $$state = getState().main
    # check key
    app_id = $$state.getIn ['wel', 'app_id']
    ssad_key = $$state.getIn ['wel', 'ssad_key']
    ssad_server_api.app_id app_id
    ssad_server_api.ssad_key ssad_key
    try
      await ssad_server_api.check_key()
      # OK
      dispatch key_ok()
      # save key in localStorage
      util.set_config {
        app_id
        ssad_key
      }
      # check current page
      current_page = getState().nav.get 'current'
      if current_page == 'page_welcome'
        # just go back
        dispatch n_action.back()
    catch e
      dispatch key_err(e)
      # goto welcome page
      dispatch n_action.go('page_welcome')

key_ok = ->
  {
    type: WELCOME_KEY_OK
  }

key_err = (err) ->
  {
    type: WELCOME_KEY_ERR
    error: true
    payload: err
  }

module.exports = {
  WELCOME_CHANGE_ID
  WELCOME_CHANGE_KEY
  WELCOME_CHECK_KEY
  WELCOME_KEY_OK
  WELCOME_KEY_ERR

  change_id
  change_key
  check_key  # thunk
  key_ok
  key_err
}
