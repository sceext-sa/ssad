# index.coffee, ssad/ssad_app/ssad_file_list/src/
#
# use global:
#   $

{
  createStore
  applyMiddleware
} = require 'redux'
thunk = require('redux-thunk').default
# DEBUG redux in browser
{ composeWithDevTools } = require 'redux-devtools-extension'

{ Provider } = require 'react-redux'
{ createElement: cE } = require 'react'
ReactDOM = require 'react-dom'
cC = require 'create-react-class'

reducer = require './redux/reducer'
action = require './redux/action'

config = require './config'
async_ = require './async'
util = require './util'

ssad_server_api = require './ssad_server_api'
event_api = require './event_api'

# use with redux
FileList = require './redux/file_list'
# redux store
store = createStore reducer, composeWithDevTools(applyMiddleware(thunk))

O = cC {
  displayName: 'O'
  # TODO

  componentDidMount: ->
    # init try-load
    store.dispatch action.load('.')
    console.log "DEBUG: init try-load"

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
  # TODO init args options from url ?
  # render root element
  ReactDOM.render (cE O), document.getElementById('root')
  # DEBUG ssad_server version
  v = await async_.get_json config.SERVER_VERSION
  console.log "DEBUG: ssad_server version #{JSON.stringify v}"
  # TODO maybe init try-load here ?

_start_init = ->
  init().then( () ->
    console.log "DEBUG: init done"
  ).catch( (e) ->
    console.log "DEBUG: init error !  #{e}"
  )
# start global init after page load
$ _start_init

# for DEBUG ?
module.exports = {
  store
}
