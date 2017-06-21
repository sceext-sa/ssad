# main.coffee, ssad/android_apk/ssad/src/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/main'

_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.main
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    #when ac.MAIN_INIT
    when ac.MAIN_SERVICE_CHANGED
      $$o = $$o.set 'service_status', action.payload
  $$o

module.exports = reducer
