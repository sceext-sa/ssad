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


PageServer = cC {
  render: ->
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
            text: 'TODO (unknow server status)'
            })
          # TODO open browser
          (cE UrlLink, {
            url: 'http://127.0.0.1:4444/(TODO)'
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
        # TODO start/stop server button
        (cE btn.BigPrimaryButton, {
          text: 'Start server'
          no_margin: true
          })
      )
    )
}
PageServer.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'ssad_server'
      header_props: props
      })
}

module.exports = PageServer
