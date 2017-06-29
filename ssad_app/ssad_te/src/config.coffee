# config.coffee, ssad/ssad_app/ssad_te/src/

P_VERSION = 'ssad_te version 0.1.0-1 test20170629 2115'

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

  # core editor single instance
  core_codemirror: null
  core_ace: null
}

# get/set
store = (s) ->
  if s?
    _etc.store = s
  _etc.store

core_codemirror = (c) ->
  if c?
    _etc.core_codemirror = c
  _etc.core_codemirror

core_ace = (c) ->
  if c?
    _etc.core_ace = c
  _etc.core_ace


module.exports = {
  P_VERSION
  LOCAL_STORAGE_KEY

  AUTO_SAVE

  store  # get/set
  core_codemirror  # get/set
  core_ace  # get/set
}
