# state.coffee, ssad/android_apk/ssad/src/redux/

init_state = {  # with Immutable
  main: {
    service_status: null
  }
  page_service: {
    is_server_running: null
    is_clip_running: null
    disable_server_button: false
    disable_clip_button: false
    server_port: null
  }
  page_tools: {
    # url to start webview
    url: 'http://html5test.com'
  }
  page_setting: {
    config: {
      port: 4444
      root_key: null
      root_app: '/sdcard/ssad/app/root_app/'
    }
    # new_config: {}
  }
}

module.exports = init_state
