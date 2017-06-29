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
util = require './util'
core_editor = require './core_editor'
reducer = require './redux/root_reducer'
a_config_id_key = require './redux/action/a_config_id_key'

# use with redux
MainHost = require './redux/main_host'
CMainTopBar = require './redux/connect/c_main_top_bar'

middleware = applyMiddleware thunk
if composeWithDevTools?
  middleware = composeWithDevTools middleware
# redux store
store = createStore reducer, middleware
config.store store  # save global store


_load_config = ->
  c = util.get_config()
  if c?
    if c.app_id?
      store.dispatch a_config_id_key.change_id(c.app_id)
      if c.ssad_key?
        store.dispatch a_config_id_key.change_key(c.ssad_key)
        store.dispatch a_config_id_key.key_ok()

_init = ->
  # TODO support switch between codemirror / ace core_editor ?
  # create CodeMirror editor
  core_editor.get_editor core_editor.CODEMIRROR, document.getElementById('root_core_editor')
  # TODO other core_editor init process
  # load config from localStorage
  _load_config()
  # TODO load config from ssad_server (app/etc file ?)

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
    console.log "DEBUG: init error !  #{e.stack}"
  )
# start after page load
$ _start_init
