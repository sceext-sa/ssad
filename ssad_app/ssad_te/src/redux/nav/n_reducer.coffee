# n_reducer.coffee, ssad/ssad_app/ssad_te/src/redux/nav/

Immutable = require 'immutable'

state = require '../state'
ac = require './n_action'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.nav
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  #switch action.type
  # TODO
  $$o

module.exports = reducer
