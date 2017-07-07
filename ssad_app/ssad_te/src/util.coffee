# util.coffee, ssad/ssad_app/ssad_te/src/
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

_ACTIVE = 'active'
# set .active class
set_core_active_cm = ->
  $('.core_editor').removeClass _ACTIVE
  $('#root_core_editor_cm').addClass _ACTIVE
set_core_active_ace = ->
  $('.core_editor').removeClass _ACTIVE
  $('#root_core_editor_ace').addClass _ACTIVE


module.exports = {
  get_config
  set_config

  set_core_active_cm
  set_core_active_ace
}
