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

start_server = (port) ->
  opt = {
    name: 'server_service'
    port
  }
  await _n.start_service JSON.stringify(opt)

stop_server = ->
  opt = {
    name: 'server_service'
  }
  await _n.stop_service JSON.stringify(opt)

start_clip = ->
  opt = {
    name: 'clip_service'
  }
  await _n.start_service JSON.stringify(opt)

stop_clip = ->
  opt = {
    name: 'clip_service'
  }
  await _n.start_service JSON.stringify(opt)

pull_events = ->
  raw = await _n.pull_events()
  JSON.parse raw

# get/set root_key
root_key = (key) ->
  if key?
    await _n.set_root_key key
  else
    await _n.get_root_key()

make_root_key = ->
  await _n.make_root_key()


SERVICE_CHANGED = 'service_changed'
# auto pull_events loop
_auto_pull_loop = ->
  while true
    # TODO error process ?
    events = await pull_events()
    if events?
      for i in events
        _listener.emit i.type, i.data
        # check for 'service_changed' event
        switch i.type
          when 'service_started', 'service_stopped'
            _listener.emit SERVICE_CHANGED, i.data

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

  start_server  # async
  stop_server  # async
  start_clip  # async
  stop_clip  # async

  root_key  # async
  make_root_key  # async

  event_listener
  SERVICE_CHANGED
}
