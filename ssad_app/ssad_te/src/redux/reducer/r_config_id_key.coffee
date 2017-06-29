# r_config_id_key.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_config_id_key'


# $$o = state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.CONFIG_CHANGE_ID
      $$o = $$o.setIn ['config', 'app_id'], action.payload
    when ac.CONFIG_CHANGE_KEY
      $$o = $$o.setIn ['config', 'ssad_key'], action.payload
    when ac.CONFIG_KEY_OK
      # copy app_id/ssad_key to up level (main)
      $$o = $$o.set 'app_id', $$o.getIn(['config', 'app_id'])
      $$o = $$o.set 'ssad_key', $$o.getIn(['config', 'ssad_key'])
      # reset error
      $$o = $$o.setIn ['config', 'error'], null
      # reset input key
      $$o = $$o.setIn ['config', 'ssad_key'], ''
    when ac.CONFIG_KEY_ERROR
      $$o = $$o.setIn ['config', 'error'], action.payload
  $$o

module.exports = reducer
