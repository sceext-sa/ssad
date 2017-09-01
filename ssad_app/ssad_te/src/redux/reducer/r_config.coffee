# r_config.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_config'
# sub reducers
r_config_id_key = require './r_config_id_key'
r_config_core = require './r_config_core'


# $$o = state.main
reducer = ($$o, action) ->
  #switch action.type
  # TODO
  # call sub reducers
  $$o = r_config_id_key $$o, action
  $$o = $$o.update 'config', ($$config) ->
    r_config_core $$config, action
  $$o

module.exports = reducer
