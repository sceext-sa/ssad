# r_common.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_common'

# TODO load and merge other sub reducers ?


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.main
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  #switch action.type
  # TODO
  #else: TODO call other sub reducers ?
  $$o

module.exports = reducer
