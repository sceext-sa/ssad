# index.coffee, ssad/ssad_app/ssad_te/src/
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
reducer = require './redux/root_reducer'

# use with redux
MainHost = require './redux/main_host'
CMainTopBar = require './redux/connect/c_main_top_bar'

middleware = applyMiddleware thunk
if composeWithDevTools?
  middleware = composeWithDevTools middleware
# redux store
store = createStore reducer, middleware
config.store store  # save global store


# TODO auto load config after page load ?
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

OT = cC {  # CMainTopBar
  displayName: 'OT'

  render: ->
    (cE Provider, {
      store
      },
      (cE CMainTopBar)
    )
}

# main entry
init = ->
  # render root elements
  ReactDOM.render (cE OT), document.getElementById('root_main_top_bar')
  ReactDOM.render (cE OM), document.getElementById('root')
  # other init
  await _init()

_start_init = ->
  init().then( () ->
    # TODO
  ).catch( (e) ->
    console.log "DEBUG: init error !  #{e}"
  )
# start after page load
$ _start_init
