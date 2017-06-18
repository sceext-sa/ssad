# ss.coffee, ssad/android_apk/ssad/src/style/

{ StyleSheet } = require 'react-native'

co = require './color'


ss = StyleSheet.create {
  # button styles
  btn: {  # common button style
    fontWeight: 'bold'
  }
  btn_n: {  # normal button
    backgroundColor: co.bg_btn
    color: co.text_btn
  }
  btn_p: {  # primary button
    backgroundColor: co.bg_btn_p
    color: co.text_btn
  }
  btn_disabled: {  # disabled button
    backgroundColor: co.bg_btn
    color: co.text_btn_disabled
  }
  btn_danger: {  # danger button
    backgroundColor: co.bg_btn_danger
    color: co.text_btn_danger
  }

  # input area
  input: {
    backgroundColor: co.bg_in
    color: co.text_in
  }
  # normal (container) area
  box: {
    backgroundColor: co.bg
  }
  # second area
  box_sec: {
    backgroundColor: co.bg_sec
  }
  # second text
  text_sec: {
    color: co.text_sec
  }

  # title and text
  title: {
    color: co.title
  }
  text: {
    color: co.text
  }

  # navigation title
  nav_box: {
    backgroundColor: co.bg_nav
  }
  nav_title: {
    color: co.title
  }
  nav_back: {
    color: co.text_sec
  }
  # main nav (main_page) style
  nav_main: {
    alignSelf: 'center'
  }
}

module.exports = ss
