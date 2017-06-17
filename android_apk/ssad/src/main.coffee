# main.coffee, ssad/android_apk/ssad/src/

{ createStore } = require 'redux'
Immutable = require 'immutable'


# TODO

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  AppRegistry
  StyleSheet
  Text
  View
} = require 'react-native'

Main = cC {
  render: ->
    (cE View, {
      style: ss.container
      },
      (cE Text, {
        style: ss.title
        },
        'SSA Daemon'
      )
      (cE Text, {
        style: ss.text
        },
        'hello, test ! '
      )
    )
}

ss = StyleSheet.create {
  container: {
    flex: 1
    justifyContent: 'center'
    alignItems: 'center'
    backgroundColor: '#050c00'
  }
  title: {
    fontSize: 20
    color: '#ffffff'
    textAlign: 'center'
    margin: 10
  }
  text: {
    textAlign: 'center'
    color: '#aaaaaa'
    marginBottom: 5
  }
}

AppRegistry.registerComponent 'ssad', () ->
  Main
module.exports = Main
