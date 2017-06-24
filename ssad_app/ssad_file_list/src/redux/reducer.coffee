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
  switch action.type
    #when ac.FL_LOAD  # TODO
    #when ac.FL_SELECT_FILE  # TODO
    when ac.FL_LOAD_OK
      # save data
      $$o = $$o.set 'data', Immutable.fromJS(action.payload)

      $$o = $$o.set 'path', action.payload.path
      $$o = $$o.set 'error', null
    when ac.FL_LOAD_ERR
      $$o = $$o.set 'error', action.payload

    when ac.FL_SET_PATH
      $$o = $$o.set 'path', action.payload
    when ac.FL_SET_ROOT_PATH
      $$o = $$o.set 'root_path', action.payload.root_path
      $$o = $$o.set 'sub_root', action.payload.sub_root
      # also set path
      $$o = $$o.set 'path', action.payload.root_path
    when ac.FL_SET_APP_ID
      $$o = $$o.set 'app_id', action.payload
      # copy to input
      $$o = $$o.setIn ['input', 'id'], action.payload
    when ac.FL_SET_SSAD_KEY
      $$o = $$o.set 'ssad_key', action.payload
    when ac.FL_SET_SHOW_PATH
      $$o = $$o.set 'show_path', action.payload
    when ac.FL_UPDATE_ROOT_PATH
      # just copy current path to root_path
      $$o = $$o.set 'root_path', $$o.get('path')

    when ac.FL_CHANGE_ID
      $$o = $$o.setIn ['input', 'id'], action.payload
    when ac.FL_CHANGE_KEY
      $$o = $$o.setIn ['input', 'key'], action.payload
    when ac.FL_SAVE_CONFIG
      $$input = $$o.get 'input'
      $$o = $$o.set 'app_id', $$input.get('id')
      $$o = $$o.set 'ssad_key', $$input.get('key')
      # reset input
      $$o = $$o.setIn ['input', 'key'], ''
  $$o

# not use  redux.combineReducers
module.exports = reducer
