# index.coffee, ssad/ssad_app/ssad_file_list/src/
#
# use global:
#   React, ReactDOM, $, ReactRedux

{
  createStore
  applyMiddleware
} = require 'redux'
thunk = require('redux-thunk').default

{ Provider } = ReactRedux
{ createElement: cE } = React
cC = require 'create-react-class'

reducer = require './redux/reducer'
action = require './redux/action'
# TODO
ssad_server_api = require './ssad_server_api'
event_api = require './event_api'
util = require './util'
async_ = require './async'

# use with redux
FileList = require './redux/file_list'
# redux store
store = createStore reducer, applyMiddleware(thunk)

O = cC {
  # TODO

  componentDidMount: ->
    # TODO
    console.log "DEBUG: root component did mount"

  componentWillUnmount: ->
    # TODO
    console.log "DEBUG: root component will unmount"

  render: ->
    (cE Provider, {
      store
      },
      # TODO support init (start) path ?
      (cE FileList)
    )
}


# main entry
init = ->
  console.log "DEBUG: start init .. . "
  # TODO

  # render root element
  ReactDOM.render (cE O), document.getElementById('root')

# start global init after page load
$ init

# for DEBUG ?
module.exports = {
  store
}
