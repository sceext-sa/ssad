# config.coffee, ssad/ssad_app/ssad_te/src/

P_VERSION = 'ssad_te version 0.1.0-1 test20170628 1914'

# localStorage key
LOCAL_STORAGE_KEY = 'ssad_te_config'

# auto save path
AUTO_SAVE = {
  sub_root: 'tmp'
  sub_path: 'auto_save'
}

# TODO default editor config ?


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

  AUTO_SAVE

  store  # get/set
}
