# server.coffee, ssad/android_apk/ssad/src/page/

React = require 'react'
{
  createClass: cC
  createFactory: cF
  createElement: cE
} = React

{
  StyleSheet
  View
  ScrollView
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

Hr = require '../sub/hr'
Input = require '../sub/input'
NavHeader = require '../sub/nav_header'
P = require '../sub/p'
TextArea = require '../sub/text_area'
Title = require '../sub/title'
UrlLink = require '../sub/url_link'

btn = require '../sub/btn'
config = require '../config'
ssad_native = require '../ssad_native'


PageServer = cC {
  getInitialState: ->
    {
      status: null
      disable_main_button: false
    }

  _update_status: ->
    status = await ssad_native.status()
    if status?
      @setState {
        status
      }
    # TODO should not disable button (FIXME)
    if @state.disable_main_button
      @setState {
        disable_main_button: false
      }

  _on_start_server: ->
    @setState {
      disable_main_button: true
    }
    await ssad_native.start_service 'server_service'
    # TODO

  _on_stop_server: ->
    @setState {
      disable_main_button: true
    }
    await ssad_native.stop_service 'server_service'

  componentDidMount: ->
    await @_update_status()
    # add event listeners
    ssad_native.event_listener().on 'service_started', @_update_status
    ssad_native.event_listener().on 'service_stopped', @_update_status

  componentWillUmount: ->
    # remove event listeners
    ssad_native.event_listener().removeListener 'service_started', @_update_status
    ssad_native.event_listener().removeListener 'service_stopped', @_update_status

  render: ->
    server_status = '(unknow)'
    if @state.status?
      if @state.status.service_running_server
        server_status = 'Server service is running'  # TODO port ?
      else
        server_status = 'Server service NOT running'

    (cE View, {
      style: {
        flex: 1
      }
      },
      (cE ScrollView, {
        style: ss.scroll
        contentContainerStyle: [ ss.box, ss.scroll_in ]
        },
        (cE View, {
          style: [ss.scroll_pad, {
            flex: 1
          } ]
          },
          # server current status
          (cE Title, {
            text: 'Status'
            })
          (cE TextArea, {
            text: server_status
            })
          # open browser
          (cE UrlLink, {
            url: 'http://127.0.0.1:4444/(TODO)'  # TODO
            })
          # config
          (cE Hr, {
            marginTop: 20
            marginBottom: 0
            })
          # ---
          (cE View, {
            style: {
              flexDirection: 'row'
              alignItems: 'flex-start'
            } },
            (cE View, { style: { flex: 1 } },
              (cE Title, {
                text: 'Settings'
                })
            )
            # TODO support save config
            (cE btn.Button, {
              text: 'Save'
              no_margin: true
              })
          )
          # port (ssad_server to listen)
          (cE View, {
            style: {
              flexDirection: 'row'
              alignItems: 'center'
              marginTop: 10
            } },
            (cE View, {
              style: {
                flex: 1
              } },
              (cE P, {
                text: 'port'
                })
            )
            (cE View, {
              style: {
                width: 64
              } },
              (cE Input, {
                default_value: '65536'  # TODO
                right: true
                })
            )
          )
          # root-key / root-app
          (cE Hr)
          (cE View, {
            flexDirection: 'row'
            },
            (cE View, {
              style: {
                flex: 1
              } },
              (cE P, {
                text: 'root key'
                })
            )
            # re-generate root-key button
            (cE btn.Button, {
              text: 'make'
              })
          )
          # TODO support copy ?
          (cE TextArea, {
            selectable: true
            sec: true
            text: 'root_key% .. . ? (TODO)'
            })
          # ---
          (cE Hr)
          (cE P, {
            text: 'root app'
            })
          (cE View, {
            style: {
              flexDirection: 'row'
            } },
            (cE Input, {
              default_value: '/sdcard/ssad/app/root_app/'
              })
          )
          # TODO init config files ?
        )
        # start/stop server button
        @_render_main_button()
      )
    )

  _render_main_button: ->
    if ! @state.status?
      return null
    if @state.status.service_running_server
      (cE btn.BigDangerButton, {
        text: 'Stop server'
        no_margin: true
        on_click: @_on_stop_server
        disabled: @state.disable_main_button
        })
    else
      (cE btn.BigPrimaryButton, {
        text: 'Start server'
        no_margin: true
        on_click: @_on_start_server
        disabled: @state.disable_main_button
        })
}
PageServer.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'ssad_server'
      header_props: props
      })
}

module.exports = PageServer
