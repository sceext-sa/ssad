# state.coffee, ssad/ssad_app/ssad_file_list/src/redux/

init_state = {  # with Immutable
  root_path: null  # current sub_root's path on disk
  sub_root: null   # sub_root of this root_path

  path: null  # current path
  data: null  # raw data from ssad_server's res

  # app ID / key
  app_id: null
  ssad_key: null

  error: null  # server error info  ( ID/key error)
  # input_key
  input: {
    id: ''
    key: ''
  }
}

module.exports = init_state
