# r_common.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_common'
# sub reducers
# TODO


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.main
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  # TODO
  $$o

module.exports = reducer
