# r_file.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_file'
# sub reducers
r_file_select = require './r_file_select'


# $$o = action.main
reducer = ($$o, action) ->
  #switch action.type
  # TODO
  # call sub reducers
  $$o = r_file_select $$o, action
  $$o

module.exports = reducer
