# index.coffee, ssad/ssad_app/ssad_todo/src/
#
# use global:
#   $, document

{
  createStore
  applyMiddleware
} = require 'redux'
thunk = require('redux-thunk').default
# DEBUG redux
{ composeWithDevTools } = require 'redux-devtools-extension'

{ Provider } = require 'react-redux'
{ createElement: cE } = require 'react'
cC = require 'create-react-class'
ReactDOM = require 'react-dom'


config = require './config'
util = require './util'
reducer = require './ui/redux/root_reducer'
# TODO

# use with redux
MainHost = require './ui/redux/main_host'

middleware = applyMiddleware thunk
if composeWithDevTools?
  middleware = composeWithDevTools middleware
# redux store
store = createStore reducer, middleware
#config.store store  # TODO save global store


# TODO _load_config ?

_init = ->
  # TODO
  await return

OM = cC {  # MainHost
  displayName: 'OM'

  render: ->
    (cE Provider, {
      store
      },
      (cE MainHost)
    )
}

# main entry
init = ->
  # render react root element
  ReactDOM.render (cE OM), document.getElementById('root')
  # other init
  await _init()

_start_init = ->
  init().then( () ->
    # TODO
  ).catch (e) ->
    console.log "DEBUG: init error !  #{e.stack}"
# start after page load
$ _start_init
