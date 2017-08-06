# r_common.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_common'
# sub reducers
r_welcome = require './r_welcome'
# TODO


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.main
  $$o

# $$state: state.main
reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  # TODO
  # call sub reducers
  $$o = r_welcome $$o, action
  $$o

module.exports = reducer
