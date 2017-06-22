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
    # TODO

  componentDidMount: ->
    store.dispatch action.init()
    # TODO add event listeners

  componentWillUnmount: ->
    # TODO remove event listeners

  render: ->
    (cE Provider, {
      store
      },
      (cE ClipList)
    )
}
module.exports = O
