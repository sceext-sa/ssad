# r_file.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_file'
# sub reducers
r_file_select = require './r_file_select'


# $$o = state.main
reducer = ($$o, action) ->
  switch action.type
    #when ac.FILE_SAVE  # TODO
    when ac.FILE_OPEN
      # set global filename
      $$o = $$o.set 'filename', $$o.getIn(['file', 'filename'])
    #when ac.FILE_ERROR  # TODO
    else
      # call sub reducers
      $$o = r_file_select $$o, action
  $$o

module.exports = reducer
