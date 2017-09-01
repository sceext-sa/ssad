# config.coffee, ssad/ssad_app/ssad_todo/src/

P_VERSION = 'ssad_todo version 0.2.0 test20170902 0104'

# localStorage key
LOCAL_STORAGE_KEY = 'ssad_todo_config'
LOCAL_STORAGE_CONFIG_INIT_LOAD_THREAD = 'ssad_todo_config_init_load_thread'


# TD data root (ssad_server: sub_root)
TD_ROOT = 'data'

# default number of one task to load history
DEFAULT_LOAD_HISTORY_N = 16
# default number of disabled task to load
DEFAULT_LOAD_DISABLED_N = 16
# number of items to load of 'load more'
LOAD_MORE_ONCE_N = 8
# multi-thread init_load
INIT_LOAD_THREAD_N = 8

# refresh task calc, every N second
REFRESH_TASK_CALC_TIME_S = 10


# global data
_etc = {
  store: null  # redux store
}

# get/set
store = (s) ->
  if s?
    _etc.store = s
  _etc.store

module.exports = {
  P_VERSION
  LOCAL_STORAGE_KEY

  TD_ROOT
  DEFAULT_LOAD_HISTORY_N
  DEFAULT_LOAD_DISABLED_N
  LOAD_MORE_ONCE_N
  INIT_LOAD_THREAD_N

  REFRESH_TASK_CALC_TIME_S

  store  # get/set
}
