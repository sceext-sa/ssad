# page_tools.coffee, ssad/android_apk/ssad/src/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/page_service'

_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.page_service
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.PAGE_SERVICE_START_SERVER
      $$o = $$o.set 'disable_server_button', true
    when ac.PAGE_SERVICE_STOP_SERVER
      $$o = $$o.set 'disable_server_button', true
    when ac.PAGE_SERVICE_START_CLIP
      $$o = $$o.set 'disable_clip_button', true
    when ac.PAGE_SERVICE_STOP_CLIP
      $$o = $$o.set 'disable_clip_button', true
    when ac.PAGE_SERVICE_CHANGED
      status = action.payload
      is_server_run = status.service_running_server
      is_clip_run = status.service_running_clip
      # check enable button
      if is_server_run != $$o.get('is_server_running')
        $$o = $$o.set 'disable_server_button', false
      if is_clip_run != $$o.get('is_clip_running')
        $$o = $$o.set 'disable_clip_button', false
      # update running status
      $$o = $$o.set 'is_server_running', is_server_run
      $$o = $$o.set 'is_clip_running', is_clip_run
      # set server_port
      if is_server_run
        $$o = $$o.set 'server_port', status.server_port
      else
        $$o = $$o.set 'server_port', null
  $$o

module.exports = reducer
