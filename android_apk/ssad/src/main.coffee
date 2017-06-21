# main.coffee, ssad/android_apk/ssad/src/

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
{ StackNavigator } = require 'react-navigation'

ss = require './style/ss'
root_reducer = require './redux/root_reducer'
action = require './redux/action/main'
ssad_native = require './ssad_native'

# use with redux
PageMain = require './page/main'
PageService = require './redux/page_service'
PageTools = require './redux/page_tools'
PageAbout = require './page/about'
PageSetting = require './redux/page_setting'

# use react-navigation
Main = StackNavigator {
  page_main: { screen: PageMain }
  page_service: { screen: PageService }
  page_tools: { screen: PageTools }
  page_about: { screen: PageAbout }
  page_setting: { screen: PageSetting }
}, {
  headerMode: 'screen'
  cardStyle: ss.box
}

# create redux store
store = createStore root_reducer, applyMiddleware(thunk)

O = cC {
  _on_service_changed: ->
    store.dispatch action.service_changed()

  componentDidMount: ->
    # add event listeners
    ssad_native.listener().on ssad_native.SERVICE_CHANGED, @_on_service_changed
    # start main init
    store.dispatch action.init()

  componentWillUnmount: ->
    # remove event listeners
    ssad_native.listener().removeListener ssad_native.SERVICE_CHANGED, @_on_service_changed

  render: ->
    (cE Provider, {
      store
      },
      (cE Main)
    )
}
module.exports = O
