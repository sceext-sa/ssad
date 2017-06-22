# ssad_clip.coffee, ssad/android_apk/ssad/src/clip/

{
  createStore
  applyMiddleware
} = require 'redux'
thunk = require('redux-thunk').default

{ Provider } = require 'react-redux'

{
  createClass: cC
  createElement: cE
} = require 'react'

ss = require '../style/ss'
root_reducer = require './redux/root_reducer'
action = require './redux/action/clip_list'
ssad_native = require '../ssad_native'

# use with redux
ClipList = require './redux/clip_list'

# create redux store
store = createStore root_reducer, applyMiddleware(thunk)

O = cC {
  _on_clip_changed: ->
    # get new clip data
    data = await ssad_native.get_clip()
    store.dispatch action.changed(data)

  componentDidMount: ->
    # create event puller
    @_puller = new ssad_native.EventPuller ssad_native.pull_events_clip
    # add event listeners
    @_puller.on 'clip_changed', @_on_clip_changed
    store.dispatch action.init()
    # start pull
    @_puller.start_pull()

  componentWillUnmount: ->
    # remove event listeners
    @_puller.removeListener 'clip_changed', @_on_clip_changed

  render: ->
    (cE Provider, {
      store
      },
      (cE ClipList)
    )
}
module.exports = O
