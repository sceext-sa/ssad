# config.coffee, ssad/ssad_app/ssad_todo/src/

P_VERSION = 'ssad_todo version 0.1.0-1 test20170806 2218'

# localStorage key
LOCAL_STORAGE_KEY = 'ssad_todo_config'

# TODO


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

  store  # get/set
}
