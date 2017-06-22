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

# for SSAD clip
set_primary_clip = (text) ->
  await _n.set_primary_clip text

get_clip = ->
  raw = await _n.get_clip()
  JSON.parse raw

set_clip = (data) ->
  await _n.set_clip JSON.stringify(data)

pull_events_clip = ->
  raw = await _n.pull_events_clip()
  JSON.parse raw

load_clip_file = ->
  await _n.load_clip_file()


# auto pull events
class EventPuller extends EventEmitter
  constructor: (fn_pull_events) ->
    super()
    @_pull_events = fn_pull_events

  start_pull: ->
    that = this
    callback = ->
      that._auto_pull_loop()
    setTimeout callback, 0

  _auto_pull_loop: ->
    while true  # exit on error
      events = await @_pull_events()
      if events?
        for i in events
          @emit i.type, i.data


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

  # SSAD clip
  set_primary_clip  # async
  get_clip  # async
  set_clip  # async
  pull_events_clip  # async
  load_clip_file  # async

  EventPuller  # class
}
