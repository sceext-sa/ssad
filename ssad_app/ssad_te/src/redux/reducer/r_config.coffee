# r_config.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_config'
# sub reducers
r_config_id_key = require './r_config_id_key'


# $$o = state.main
reducer = ($$o, action) ->
  #switch action.type
  # TODO
  # call sub reducers
  $$o = r_config_id_key $$o, action
  $$o

module.exports = reducer
