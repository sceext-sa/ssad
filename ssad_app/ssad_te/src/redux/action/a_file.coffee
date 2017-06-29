# a_file.coffee, ssad/ssad_app/ssad_te/src/redux/action/


# action types

FILE_SAVE = 'file_save'
FILE_OPEN = 'file_open'


save = ->
  (dispatch, getState) ->
    # TODO
    await return

open = ->
  (dispatch, getState) ->
    # TODO
    await return

module.exports = {
  FILE_SAVE
  FILE_OPEN

  save  # thunk
  open  # thunk
}
