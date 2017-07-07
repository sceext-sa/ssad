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
a_count = require './redux/action/a_count'

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

_init_auto_count = ->
  # init count
  store.dispatch a_count.refresh()
  sleep_time = config.AUTO_COUNT_SLEEP_S * 1e3

  last_mark = null  # TODO only for codemirror
  # TODO improve performance (for ACE)
  _update_clean_mark = ->
    c = core_editor.get_current_core_name()
    if c == core_editor.CORE_EDITOR_CODEMIRROR
      core = core_editor.get_core()
      last_mark = core.get_clean_mark()
  _update_clean_mark()

  _check_count = ->
    is_clean = false
    c = core_editor.get_current_core_name()
    if c == core_editor.CORE_EDITOR_CODEMIRROR
      core = core_editor.get_core()
      if core.is_clean(last_mark)
        is_clean = true
    if ! is_clean
      # should count
      store.dispatch a_count.refresh()
      _update_clean_mark()
    setTimeout _check_count, sleep_time
  # start auto count
  setTimeout _check_count, sleep_time

_init_auto_save = ->
  # TODO

_init = ->
  # TODO support switch between codemirror / ace core_editor ?
  # init core_editor
  core_editor.set_core_root_element core_editor.CORE_EDITOR_CODEMIRROR, document.getElementById('root_core_editor_cm')
  core_editor.set_core_root_element core_editor.CORE_EDITOR_ACE, document.getElementById('root_core_editor_ace')
  # TODO init core is codemirror
  core_editor.set_core core_editor.CORE_EDITOR_CODEMIRROR
  util.set_core_active_cm()

  # load config from localStorage
  _load_config()
  # auto count
  _init_auto_count()
  # TODO load config from ssad_server (app/etc file ?)
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
