# root_reducer.coffee, ssad/ssad_app/ssad_te/src/redux/

{ combineReducers } = require 'redux'

nav = require './nav/n_reducer'
main = require './reducer/r_common'

root_reducer = combineReducers {
  nav
  main
}
module.exports = root_reducer
