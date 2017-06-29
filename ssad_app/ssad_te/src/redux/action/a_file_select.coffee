# a_file_select.coffee, ssad/ssad_app/ssad_te/src/redux/action/

n_action = require '../nav/n_action'


# action types

FILE_LOAD_DIR = 'file_load_dir'
FILE_SELECT_FILE = 'file_select_file'
FILE_SELECT_ERROR = 'file_select_error'


load_dir = (data) ->
  {
    type: FILE_LOAD_DIR
    payload: data
  }

select_file = (data) ->
  (dispatch, getState) ->
    dispatch {
      type: FILE_SELECT_FILE
      payload: data
    }
    # nav back
    dispatch n_action.back()
    await return

select_error = (error) ->
  (dispatch, getState) ->
    # TODO
    dispatch {
      type: FILE_SELECT_ERROR
      error: true
      payload: error
    }
    # TODO
    await return


module.exports = {
  FILE_LOAD_DIR
  FILE_SELECT_FILE
  FILE_SELECT_ERROR

  load_dir
  select_file  # thunk
  select_error  # thunk
}
