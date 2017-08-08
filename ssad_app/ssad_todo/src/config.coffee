# config.coffee, ssad/ssad_app/ssad_todo/src/

P_VERSION = 'ssad_todo version 0.1.0-1 test20170808 1430'

# localStorage key
LOCAL_STORAGE_KEY = 'ssad_todo_config'

# TD data root (ssad_server: sub_root)
TD_ROOT = 'data'

# default number of one task to load history
DEFAULT_LOAD_HISTORY_N = 16


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

  store  # get/set
}
