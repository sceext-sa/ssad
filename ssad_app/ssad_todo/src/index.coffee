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
a_td = require './ui/redux/action/a_td'
a_config = require './ui/redux/action/a_config'

# use with redux
MainHost = require './ui/redux/main_host'

middleware = applyMiddleware thunk
if composeWithDevTools?
  middleware = composeWithDevTools middleware
# redux store
store = createStore reducer, middleware
config.store store  # save global store


_load_config = ->
  # load init_load_thread
  n = Number.parseInt util.get_config_init_load_thread()
  if (! Number.isNaN(n)) and (n > 0)
    # update config value
    config.INIT_LOAD_THREAD_N = n
    # update state
    store.dispatch a_config.set_init_load_thread_n(n)
    # DEBUG
    console.log "DEBUG: _load_config: init_load_thread #{n}"
  else
    store.dispatch a_config.set_init_load_thread_n(config.INIT_LOAD_THREAD_N)
  # load app_id/ssad_key
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

_init_refresh_task_calc = ->
  _refresh_once = ->
    store.dispatch a_td.calc_all()
    console.log "DEBUG: refresh task calc at #{new Date()}"
  # refresh task calc
  setInterval _refresh_once, config.REFRESH_TASK_CALC_TIME_S * 1e3

_init = ->
  # goto  [ page_main_menu, page_enable_task_list ]  on init
  store.dispatch n_action.go('page_main_menu')
  store.dispatch n_action.go('page_enable_task_list')
  # load config from localStorage
  _load_config()
  # other init
  _init_refresh_task_calc()

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
