# root_reducer.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/

{ combineReducers } = require 'redux'

nav = require './nav/n_reducer'
main = require './reducer/r_common'

root_reducer = combineReducers {
  nav
  main
}
module.exports = root_reducer
