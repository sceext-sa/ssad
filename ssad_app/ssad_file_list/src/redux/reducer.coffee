# reducer.coffee, ssad/ssad_app/ssad_file_list/src/redux/

Immutable = require 'immutable'

state = require './state'
ac = require './action'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  # TODO
  $$o

# not use  redux.combineReducers
module.exports = reducer
