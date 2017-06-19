# ssad_native.coffee, ssad/android_apk/ssad/src/

{
  EventEmitter
} = require 'events'

{
  NativeModules
} = require 'react-native'
_n = NativeModules.ssad_native


version = ->
  JSON.parse _n.VERSION_INFO

status = ->
  raw = await _n.status()
  JSON.parse raw

start_webview = (url) ->
  opt = {
    url: url
  }
  await _n.start_webview JSON.stringify(opt)

get_webview_url = ->
  await _n.get_webview_url()

# TODO support start service args ?
start_service = (name) ->
  opt = {
    name
  }
  await _n.start_service JSON.stringify(opt)

stop_service = (name) ->
  opt = {
    name
  }
  await _n.stop_service JSON.stringify(opt)

pull_events = ->
  raw = await _n.pull_events()
  JSON.parse raw


# auto pull_events loop
_auto_pull_loop = ->
  while true
    # TODO error process ?
    events = await pull_events()
    if events?
      for i in events
        _listener.emit i.type, i.data

# create global event-listener, and start auto pull
_listener = new EventEmitter()
setTimeout _auto_pull_loop, 0

# get
event_listener = ->
  _listener


module.exports = {
  version
  status  # async

  start_webview  # async
  get_webview_url  # async

  start_service  # async
  stop_service  # async

  event_listener
}
