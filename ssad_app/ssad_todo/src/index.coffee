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
n_action = require './ui/redux/nav/n_action'
a_welcome = require './ui/redux/action/a_welcome'

# use with redux
MainHost = require './ui/redux/main_host'

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
      store.dispatch a_welcome.change_id(c.app_id)
      if c.ssad_key?
        store.dispatch a_welcome.change_key(c.ssad_key)
        store.dispatch a_welcome.check_key()
        return
  # goto welcome page
  store.dispatch n_action.go('page_welcome')

_init = ->
  # goto  [ page_main_menu, page_enable_task_list ]  on init
  store.dispatch n_action.go('page_main_menu')
  store.dispatch n_action.go('page_enable_task_list')
  # load config from localStorage
  _load_config()
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
