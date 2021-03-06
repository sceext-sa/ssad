# index.coffee, ssad/ssad_app/ssad_file_list/src/
#
# use global:
#   $, document

url = require 'url'
querystring = require 'querystring'

{
  createStore
  applyMiddleware
} = require 'redux'
thunk = require('redux-thunk').default
# DEBUG redux in browser (redux remote)
{ composeWithDevTools } = require 'redux-devtools-extension'
#{ composeWithDevTools } = require 'remote-redux-devtools'
#composeWithDevTools = composeWithDevTools({ realtime: true })


{ Provider } = require 'react-redux'
{ createElement: cE } = require 'react'
cC = require 'create-react-class'
ReactDOM = require 'react-dom'

reducer = require './redux/reducer'
action = require './redux/action'

config = require './config'
async_ = require './async'

# use with redux
FileList = require './redux/file_list'
# redux store
middleware = applyMiddleware thunk
if composeWithDevTools?
  middleware = composeWithDevTools middleware
store = createStore reducer, middleware


_get_args = ->
  u = document.URL
  querystring.parse url.parse(u).query

O = cC {
  displayName: 'O'

  componentDidMount: ->
    # get args from document.URL
    a = _get_args()
    if a.app_id?
      store.dispatch action.set_app_id(a.app_id)
    if a.ssad_key?
      store.dispatch action.set_ssad_key(a.ssad_key)
    if a.sub_root? && a.root_path?
      store.dispatch action.set_root_path(a.sub_root, a.root_path)
    if a.path?
      store.dispatch action.set_path(a.path)
    if a.show_path == 'true'
      store.dispatch action.set_show_path(true)

    # init try-load
    store.dispatch action.load('.')
    console.log "DEBUG: init try-load"

  componentWillUnmount: ->
    console.log "DEBUG: root component will unmount"

  render: ->
    (cE Provider, {
      store
      },
      (cE FileList)
    )
}


# main entry
init = ->
  console.log "DEBUG: start init .. . "
  # render root element
  ReactDOM.render (cE O), document.getElementById('root')
  # DEBUG ssad_server version
  v = await async_.get_json config.SERVER_VERSION
  console.log "DEBUG: ssad_server version #{JSON.stringify v}"

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
