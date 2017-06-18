# ss.coffee, ssad/android_apk/ssad/src/style/

{ StyleSheet } = require 'react-native'

co = require './color'


ss = StyleSheet.create {
  # button styles
  btn: {  # common button style
    fontWeight: 'bold'
    fontSize: 20
    textAlign: 'center'
  }
  btn_n: {  # normal button
    #backgroundColor: co.bg_btn
    color: co.text_btn
  }
  btn_p: {  # primary button
    #backgroundColor: co.bg_btn_p
    color: co.text_btn
  }
  btn_disabled: {  # disabled button
    #backgroundColor: co.bg_btn
    color: co.text_btn_disabled
  }
  btn_danger: {  # danger button
    #backgroundColor: co.bg_btn_danger
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
    fontWeight: 'bold'
  }
  title_size: {
    fontSize: 20
  }
  text: {
    color: co.text
  }
  # defalut text size
  text_size: {
    fontSize: 15
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

  # ScrollView style
  scroll: {
    flex: 1
  }
  # ScrollView.contentContainerStyle
  scroll_in: {
    flexGrow: 1
  }
  # page in-scroll padding
  scroll_pad: {
    paddingLeft: 5
    paddingRight: 5
  }
}

module.exports = ss
