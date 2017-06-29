# a_config_id_key.coffee, ssad/ssad_app/ssad_te/src/redux/action/

ssad_server_api = require '../../ssad_server_api'
n_action = require '../nav/n_action'
util = require '../../util'

# action types
CONFIG_CHANGE_ID = 'config_change_id'
CONFIG_CHANGE_KEY = 'config_change_key'
CONFIG_KEY_OK = 'config_key_ok'
CONFIG_KEY_ERROR = 'config_key_error'


change_id = (text) ->
  {
    type: CONFIG_CHANGE_ID
    payload: text
  }
change_key = (text) ->
  {
    type: CONFIG_CHANGE_KEY
    payload: text
  }
key_error = (error) ->
  {
    type: CONFIG_KEY_ERROR
    error: true
    payload: error
  }

key_ok = ->
  (dispatch, getState) ->
    $$state = getState().main
    # check key
    app_id = $$state.getIn ['config', 'app_id']
    ssad_key = $$state.getIn ['config', 'ssad_key']
    try
      await ssad_server_api.check_key app_id, ssad_key
      # key OK
      dispatch {
        type: CONFIG_KEY_OK
      }
      # save to localStorage
      util.set_config {
        app_id
        ssad_key
      }
      # check current page
      current = getState().nav.get 'current'
      if current == 'page_config_id_key'
        # nav back
        dispatch n_action.back()
    catch e
      dispatch key_error(e)


module.exports = {
  CONFIG_CHANGE_ID
  CONFIG_CHANGE_KEY
  CONFIG_KEY_OK
  CONFIG_KEY_ERROR

  change_id
  change_key
  key_error
  key_ok  # thunk
}
