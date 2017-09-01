# r_config_core.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_config_core'


# $$o = state.main.config
reducer = ($$o, action) ->
  switch action.type
    when ac.CONFIG_CORE_SET_CORE
      $$o = $$o.set 'core_editor', action.payload
  $$o

module.exports = reducer
