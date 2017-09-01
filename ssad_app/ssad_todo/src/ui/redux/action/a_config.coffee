# a_config.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

util = require '../../../util'

# action types

CONFIG_SET_INIT_LOAD_THREAD_N = 'config_set_init_load_thread_n'
CONFIG_SET_INIT_LOAD_TIME_S = 'config_set_init_load_time_s'

CONFIG_SAVE_INIT_LOAD_THREAD_N = 'config_save_init_load_thread_n'


set_init_load_thread_n = (n) ->
  {
    type: CONFIG_SET_INIT_LOAD_THREAD_N
    payload: n
  }

set_init_load_time_s = (s) ->
  {
    type: CONFIG_SET_INIT_LOAD_TIME_S
    payload: s
  }

save_init_load_thread_n = ->
  (dispatch, getState) ->
    dispatch {  # for DEBUG
      type: CONFIG_SAVE_INIT_LOAD_THREAD_N
    }

    n = getState().main.getIn ['config', 'init_load_thread_n']
    n = Number.parseInt n
    if (! Number.isNaN(n)) and (n > 0)
      util.set_config_init_load_thread n
    # else: ignore


module.exports = {
  CONFIG_SET_INIT_LOAD_THREAD_N
  CONFIG_SET_INIT_LOAD_TIME_S
  CONFIG_SAVE_INIT_LOAD_THREAD_N

  set_init_load_thread_n
  set_init_load_time_s
  save_init_load_thread_n  # thunk
}
