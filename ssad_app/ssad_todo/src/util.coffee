# util.coffee, ssad/ssad_app/ssad_todo/src/
#
# use global:
#   localStorage, $

config = require './config'


# return null if error
get_config = ->
  value = localStorage.getItem config.LOCAL_STORAGE_KEY
  if value?
    try
      value = JSON.parse value
    catch e
      value = null
      # ignore error
  value

set_config = (data) ->
  value = JSON.stringify data
  localStorage.setItem config.LOCAL_STORAGE_KEY, value


get_config_init_load_thread = ->
  localStorage.getItem config.LOCAL_STORAGE_CONFIG_INIT_LOAD_THREAD

set_config_init_load_thread = (n) ->
  localStorage.setItem config.LOCAL_STORAGE_CONFIG_INIT_LOAD_THREAD, n


module.exports = {
  get_config
  set_config

  get_config_init_load_thread
  set_config_init_load_thread
}
