# r_common.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_common'
# sub reducers
r_config = require './r_config'
r_file = require './r_file'
r_count = require './r_count'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.main
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.C_SET_DOC_CLEAN
      $$o = $$o.set 'doc_clean', action.payload
    else
      # call sub reducers
      $$o = r_config $$o, action
      $$o = r_file $$o, action
      $$o = $$o.update 'count', ($$count) ->
        r_count $$count, action
  $$o

module.exports = reducer
