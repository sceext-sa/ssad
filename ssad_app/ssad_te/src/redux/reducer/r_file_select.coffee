# r_file_select.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

path = require 'path'
Immutable = require 'immutable'

ac = require '../action/a_file_select'


# $$o = state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.FILE_LOAD_DIR
      d = action.payload
      # update file args
      $$o = $$o.setIn ['file', 'sub_root'], d.sub_root
      $$o = $$o.setIn ['file', 'root_path'], d.root_path
      $$o = $$o.setIn ['file', 'path'], d.path
      # calc sub_path
      if d.root_path?
        sub_path = path.relative d.root_path, d.path
        $$o = $$o.setIn ['file', 'sub_path'], sub_path
      else
        $$o = $$o.setIn ['file', 'sub_path'], null  # reset sub_path
      # reset filename
      $$o = $$o.setIn ['file', 'filename'], null
    when ac.FILE_SELECT_FILE
      d = action.payload
      # update filename
      $$o = $$o.setIn ['file', 'filename'], d.filename
    #when ac.FILE_SElECT_ERROR  # TODO action.payload.error
  $$o

module.exports = reducer
