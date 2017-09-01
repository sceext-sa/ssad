# r_config.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_config'


# $$o: state.main.config
reducer = ($$o, action) ->
  switch action.type
    when ac.CONFIG_SET_INIT_LOAD_THREAD_N
      $$o = $$o.set 'init_load_thread_n', "#{action.payload}"
    when ac.CONFIG_SET_INIT_LOAD_TIME_S
      $$o = $$o.set 'init_load_time_s', Number.parseFloat(action.payload)
  $$o

module.exports = reducer
