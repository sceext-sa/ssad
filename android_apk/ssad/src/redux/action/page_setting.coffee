# page_setting.coffee, ssad/android_apk/ssad/src/redux/action/

ssad_native = require '../../ssad_native'
util = require '../../util'

# action types

PAGE_SETTING_CHANGE_PORT = 'page_setting_change_port'
PAGE_SETTING_CHANGE_ROOT_APP = 'page_setting_change_root_app'
PAGE_SETTING_MAKE_ROOT_KEY = 'page_setting_make_root_key'
PAGE_SETTING_SAVE = 'page_setting_save'
PAGE_SETTING_RESET = 'page_setting_reset'
PAGE_SETTING_LOAD_CONFIG = 'page_setting_load_config'

change_port = (text) ->
  {
    type: PAGE_SETTING_CHANGE_PORT
    payload: text
  }

change_root_app = (text) ->
  {
    type: PAGE_SETTING_CHANGE_ROOT_APP
    payload: text
  }

reset = ->
  {
    type: PAGE_SETTING_RESET
  }

make_root_key = ->
  (dispatch, getState) ->
    root_key = await ssad_native.make_root_key()

    dispatch {
      type: PAGE_SETTING_MAKE_ROOT_KEY
      payload: root_key
    }

save = ->
  (dispatch, getState) ->
    dispatch {
      type: PAGE_SETTING_SAVE
    }
    # save config
    $$state = getState().page_setting
    config = $$state.get('config').toJS()
    await util.save_config config

load_config = (config) ->
  {
    type: PAGE_SETTING_LOAD_CONFIG
    payload: config
  }

module.exports = {
  PAGE_SETTING_CHANGE_PORT
  PAGE_SETTING_CHANGE_ROOT_APP
  PAGE_SETTING_MAKE_ROOT_KEY
  PAGE_SETTING_SAVE
  PAGE_SETTING_RESET
  PAGE_SETTING_LOAD_CONFIG

  change_port
  change_root_app
  make_root_key  # thunk
  save  # thunk
  reset
  load_config
}
