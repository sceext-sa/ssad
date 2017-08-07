# r_welcome.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_welcome'

# $$o: state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.WELCOME_CHANGE_ID
      $$o = $$o.setIn ['wel', 'app_id'], action.payload
    when ac.WELCOME_CHANGE_KEY
      $$o = $$o.setIn ['wel', 'ssad_key'], action.payload
    #when ac.WELCOME_CHECK_KEY
    when ac.WELCOME_KEY_OK
      # reset error, key
      $$o = $$o.setIn ['wel', 'error'], null
      $$o = $$o.setIn ['wel', 'ssad_key'], ''
    when ac.WELCOME_KEY_ERR
      $$o = $$o.setIn ['wel', 'error'], action.payload
  $$o

module.exports = reducer
