# page_setting.coffee, ssad/android_apk/ssad/src/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/page_setting'


_to_new_config = ($$old) ->
  # str port
  $$o = $$old.set 'port', $$old.get('port').toString()
  $$o

_to_old_config = ($$old, $$new) ->
  $$o = $$new
  # parse port
  port = $$new.get 'port'
  port = Number.parseInt port
  if (Number.isNaN port) || (port < 1) || (port > 65534)
    port = $$old.get 'port'  # port check not pass, keep old port
  $$o = $$o.set 'port', port
  $$o

_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.page_setting
    # set new_config
    $$o = $$o.set 'new_config', _to_new_config($$o.get('config'))
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.PAGE_SETTING_CHANGE_PORT
      $$o = $$o.setIn ['new_config', 'port'], action.payload
    when ac.PAGE_SETTING_CHANGE_ROOT_APP
      $$o = $$o.setIn ['new_config', 'root_app'], action.payload
    when ac.PAGE_SETTING_MAKE_ROOT_KEY
      $$o = $$o.setIn ['new_config', 'root_key'], action.payload
    when ac.PAGE_SETTING_SAVE
      $$o = $$o.set 'config', _to_old_config($$o.get('config'), $$o.get('new_config'))
      # reset new config
      $$o = $$o.set 'new_config', _to_new_config($$o.get('config'))
    when ac.PAGE_SETTING_RESET
      # reset new config
      $$o = $$o.set 'new_config', _to_new_config($$o.get('config'))
  $$o

module.exports = reducer
