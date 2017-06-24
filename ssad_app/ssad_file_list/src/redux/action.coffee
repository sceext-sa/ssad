# action.coffee, ssad/ssad_app/ssad_file_list/src/redux/

path = require 'path'

config = require '../config'
util = require '../util'
ssad_server_api = require '../ssad_server_api'
event_api = require '../event_api'


# action types

FL_LOAD = 'fl_load'  # start load file list
FL_SELECT_FILE = 'fl_select_file'
FL_LOAD_OK = 'fl_load_ok'
FL_LOAD_ERR = 'fl_load_err'

FL_SET_PATH = 'fl_set_path'
FL_SET_ROOT_PATH = 'fl_set_root_path'
FL_SET_APP_ID = 'fl_set_app_id'
FL_SET_SSAD_KEY = 'fl_set_ssad_key'
FL_SET_SHOW_PATH = 'fl_set_show_path'
FL_UPDATE_ROOT_PATH = 'fl_update_root_path'

FL_CHANGE_ID = 'fl_change_id'
FL_CHANGE_KEY = 'fl_change_key'
FL_SAVE_CONFIG = 'fl_save_config'


load = (name) ->
  (dispatch, getState) ->
    dispatch {
      type: FL_LOAD
      payload: name
    }
    $$state = getState()
    # check init load or load '.'
    if ('.' == name) || (! $$state.get('data')?)
      dispatch _do_load(name)  # just load it
      return
    # check sub_root
    if ! $$state.get('sub_root')?
      data = $$state.get('data').toJS()
      root_path = data.dir[name].path
      dispatch set_root_path(name, root_path)
      dispatch _do_load('.', true)
      return

    _is_path_equal = (a, b) ->
      if ! a.endsWith('/')
        a += '/'
      if ! b.endsWith('/')
        b += '/'
      (a == b)
    # check exit to sub_root
    if ('..' == name) && _is_path_equal($$state.get('path'), $$state.get('root_path'))
      dispatch set_root_path(null, null)
      dispatch _do_load(name)
      return
    # just load it
    dispatch _do_load(name)
    await return

_do_load = (name, is_load_sub_root) ->
  (dispatch, getState) ->
    $$state = getState()
    path_ = name
    if $$state.get('path')?
      path_ = path.join $$state.get('path'), name
    opts = {
      root_path: $$state.get 'root_path'
      sub_root: $$state.get 'sub_root'
      app_id: $$state.get 'app_id'
      ssad_key: $$state.get 'ssad_key'
    }
    try
      data = await ssad_server_api.load_dir path_, opts
      dispatch load_ok(data)
      if is_load_sub_root
        # this is load sub_root, so update root_path
        dispatch update_root_path()
    catch e
      dispatch load_err(e)


load_ok = (data) ->
  {
    type: FL_LOAD_OK
    payload: data
  }

load_err = (error) ->
  {
    type: FL_LOAD_ERR
    error: true
    payload: error
  }

set_path = (path) ->
  {
    type: FL_SET_PATH
    payload: path
  }

set_root_path = (sub_root, root_path) ->
  {
    type: FL_SET_ROOT_PATH
    payload: {
      sub_root
      root_path
    }
  }

set_app_id = (id) ->
  {
    type: FL_SET_APP_ID
    payload: id
  }

set_ssad_key = (key) ->
  {
    type: FL_SET_SSAD_KEY
    payload: key
  }

set_show_path = (show) ->
  {
    type: FL_SET_SHOW_PATH
    payload: show
  }

update_root_path = ->
  {
    type: FL_UPDATE_ROOT_PATH
  }


change_id = (id) ->
  {
    type: FL_CHANGE_ID
    payload: id
  }

change_key = (key) ->
  {
    type: FL_CHANGE_KEY
    payload: key
  }

save_config = ->
  (dispatch, getState) ->
    dispatch {
      type: FL_SAVE_CONFIG
    }
    # try to load
    dispatch load('.')

select_file = (name) ->
  (dispatch, getState) ->
    dispatch {
      type: FL_SELECT_FILE
      payload: name
    }
    # TODO
    await return

module.exports = {
  FL_LOAD
  FL_SELECT_FILE
  FL_LOAD_OK
  FL_LOAD_ERR
  FL_SET_PATH
  FL_SET_ROOT_PATH
  FL_SET_APP_ID
  FL_SET_SSAD_KEY
  FL_SET_SHOW_PATH
  FL_UPDATE_ROOT_PATH

  FL_CHANGE_ID
  FL_CHANGE_KEY
  FL_SAVE_CONFIG

  load  # thunk
  select_file  # thunk
  load_ok
  load_err
  set_path
  set_root_path
  set_app_id
  set_ssad_key
  set_show_path
  update_root_path

  change_id
  change_key
  save_config  # thunk
}
