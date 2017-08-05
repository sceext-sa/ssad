# config.coffee, ssad/ssad_app/ssad_te/src/

P_VERSION = 'ssad_te version 0.2.0-3 test20170708 2336'

# localStorage key
LOCAL_STORAGE_KEY = 'ssad_te_config'

# auto save path
AUTO_SAVE = {
  sub_root: 'tmp'
  sub_path: 'auto_save'
  time_s: 60  # auto save every minute
}
# auto count
AUTO_COUNT_SLEEP_S = 3.7  # count every 3.7s


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
  AUTO_COUNT_SLEEP_S

  store  # get/set
}
