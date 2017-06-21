# ssad_native.coffee, ssad/android_apk/ssad/src/

{ EventEmitter } = require 'events'

{ NativeModules } = require 'react-native'
_n = NativeModules.ssad_native


version = ->
  JSON.parse _n.VERSION_INFO

status = ->
  raw = await _n.status()
  JSON.parse raw

get_webview_url = ->
  await _n.get_webview_url()

start_webview = (url) ->
  opt = {
    url
  }
  await _n.start_webview JSON.stringify(opt)

start_server = (port, root_key) ->
  opt = {
    port
    root_key
  }
  await _n.start_server JSON.stringify(opt)

start_clip = ->
  opt = {}
  await _n.start_clip JSON.stringify(opt)

stop_server = ->
  opt = {
    name: 'server_service'
  }
  await _n.stop_service JSON.stringify(opt)

stop_clip = ->
  opt = {
    name: 'clip_service'
  }
  await _n.stop_service JSON.stringify(opt)

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


# auto pull events and global event listener
SERVICE_CHANGED = 'service_changed'

_auto_pull_loop = ->
  while true
    events = await pull_events()
    if events?
      for i in events
        _listener.emit i.type, i.data
        # check for service_changed
        switch i.type
          when 'service_started', 'service_stopped'
            _listener.emit SERVICE_CHANGED, i.data
# create listener start auto pull
_listener = new EventEmitter()
setTimeout _auto_pull_loop, 0

# get
listener = ->
  _listener


module.exports = {
  version
  status  # async

  get_webview_url  # async
  start_webview  # async
  start_server  # async
  start_clip  # async
  stop_server  # async
  stop_clip  # async

  pull_events  # async
  root_key  # async
  make_root_key  # async

  SERVICE_CHANGED
  listener
}
