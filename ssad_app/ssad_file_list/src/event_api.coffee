# event_api.coffee, ssad/ssad_app/ssad_file_list/src/

util = require './util'


# event types
EVENT_ERROR = 'error'
EVENT_LOAD_DIR = 'load_dir'  # load dir  OK
EVENT_SELECT_FILE = 'select_file'


_post = (type, data, is_err) ->
  o = {
    type
    payload: data
  }
  if is_err? && is_err
    o.error = true
  util.post_msg o

_get_common_data = ($$state) ->
  {
    root_path: $$state.get 'root_path'
    sub_root: $$state.get 'sub_root'
    path: $$state.get 'path'
    app_id: $$state.get 'app_id'
  }

on_error = ($$state, err) ->
  data = _get_common_data $$state
  data.error = err
  _post EVENT_ERROR, data, true

on_load_dir = ($$state) ->
  data = _get_common_data $$state
  _post EVENT_LOAD_DIR, data

on_select_file = ($$state, name) ->
  data = _get_common_data $$state
  data.filename = name
  _post EVENT_SELECT_FILE, data


module.exports = {
  EVENT_ERROR
  EVENT_LOAD_DIR
  EVENT_SELECT_FILE

  on_error
  on_load_dir
  on_select_file
}
