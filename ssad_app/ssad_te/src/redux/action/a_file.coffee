# a_file.coffee, ssad/ssad_app/ssad_te/src/redux/action/

core_editor = require '../../core_editor'
ssad_server_api = require '../../ssad_server_api'
a_common = require './a_common'
n_action = require '../nav/n_action'


# action types

FILE_SAVE = 'file_save'
FILE_OPEN = 'file_open'
FILE_ERROR = 'file_error'


file_error = (error) ->
  {
    type: FILE_ERROR
    error: true
    payload: error
  }

# return null if error
_make_url = ($$state) ->
  app_id = $$state.get 'app_id'
  ssad_key = $$state.get 'ssad_key'
  sub_root = $$state.getIn ['file', 'sub_root']
  sub_path = $$state.getIn ['file', 'sub_path']
  filename = $$state.getIn ['file', 'filename']
  if (! app_id?) || (! ssad_key?) || (! sub_root?) || (! sub_path?) || (! filename?)
    return null
  ssad_server_api.make_url app_id, sub_root, sub_path, filename

save = ->
  (dispatch, getState) ->
    text = core_editor.get_text()
    # save with ssad_server
    $$state = getState().main
    url = _make_url $$state
    if ! url?
      dispatch file_error(new Error "can not make file URL")
      return
    try
      await ssad_server_api.put_text_file url, $$state.get('ssad_key'), text
      dispatch {  # save OK
        type: FILE_SAVE
      }
      # mark clean
      core_editor.mark_clean()
      # set clean
      dispatch a_common.set_doc_clean(true)
      # OK: nav back
      dispatch n_action.back()
    catch e
      dispatch file_error(e)

open = ->
  (dispatch, getState) ->
    $$state = getState().main
    url = _make_url $$state
    if ! url?
      dispatch file_error(new Error "can not make file URL")
      return
    try
      text = await ssad_server_api.load_text_file url, $$state.get('ssad_key')
      # set to editor
      core_editor.set_text text
      # mark clean
      core_editor.mark_clean()

      dispatch {  # open OK
        type: FILE_OPEN
      }
      dispatch a_common.set_doc_clean(true)
      # OK: nav back
      dispatch n_action.back()
    catch e
      dispatch file_error(e)

module.exports = {
  FILE_SAVE
  FILE_OPEN

  save  # thunk
  open  # thunk
}
