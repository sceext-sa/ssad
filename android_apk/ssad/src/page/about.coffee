# about.coffee, ssad/android_apk/ssad/src/page/

{
  createClass: cC
  createElement: cE
} = require 'react'
{
  View
  Text
  ScrollView
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

NavHeader = require '../sub/nav_header'
FullScroll = require '../sub/full_scroll'
Title = require '../sub/title'
P = require '../sub/p'
TextArea = require '../sub/text_area'
UrlLink = require '../sub/url_link'

config = require '../config'
ssad_native = require '../ssad_native'


AboutItem = cC {
  render: ->
    (cE View, {
      style: {
      } },
      (cE View, {
        style: {
          flexDirection: 'row'
          alignItems: 'center'
          paddingLeft: 5
        } },
        (cE Text, {
          style: {
            color: co.text_sec
          } },
          '+'
        )
        (cE P, {
          text: @props.name
          })
      )
      (cE View, {
        style: {
          paddingLeft: 20
          paddingRight: 16
        } },
        (cE UrlLink, {
          url: @props.url
          })
      )
    )
}

PageAbout = cC {
  _version_info: ->
    # get version_info
    v = ssad_native.version()
    o = config.P_VERSION + '\n'
    o += v.ssad_native + '\n'
    o += v.ssad_server + '\n'
    o += v.http_server + '\n'
    o

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE NavHeader, {
        title: 'About'
        navigation: @props.navigation
        })
      (cE FullScroll, null,
        (cE View, {
          style: [ ss.box, ss.scroll_pad, {
            flex: 0
          } ]
          },
          # ssad version
          (cE Title, {
            text: 'SSA Daemon'
            })
          (cE ScrollView, {
            horizontal: true
            },
            (cE P, {
              text: @_version_info()
              })
          )
          # homepage of ssad
          (cE UrlLink, {
            url: 'https://github.com/sceext-sa/ssad'
            })
          # LICENSE
          (cE View, {
            style: {
              flexDirection: 'row'
              padding: 5
              alignItems: 'center'
            } },
            (cE Text, {
              style: {
                color: co.text_sec
              } },
              'LICENSE: '
            )
            (cE Text, {
              style: {
                color: co.text
              } },
              'GNU GPL v3+'
            )
          )
        )
        (cE View, {
          style: {
            flex: 1
            paddingBottom: 16
          } },
          # technologies (library/framework) used in this program
          (cE View, {
            style: ss.scroll_pad
            },
            (cE Title, {
              text: 'Technologies'
              })
            (cE Text, {
              style: {
                color: co.text_sec
                paddingLeft: 5
              } },
              'Libraries / frameworks, etc.  used in this APP: '
            )
          )
          # netty
          (cE AboutItem, {
            name: 'netty'
            url: 'https://netty.io/'
            })
          # mjson
          (cE AboutItem, {
            name: 'mjson'
            url: 'https://bolerio.github.io/mjson/'
            })
          # react-native
          (cE AboutItem, {
            name: 'react-native'
            url: 'https://facebook.github.io/react-native/'
            })
          # redux
          (cE AboutItem, {
            name: 'redux'
            url: 'https://redux.js.org/'
            })
          # immutable-js
          (cE AboutItem, {
            name: 'immutable-js'
            url: 'https://facebook.github.io/immutable-js/'
            })
          # coffee-script
          (cE AboutItem, {
            name: 'coffee-script'
            url: 'https://coffeescript.org/'
            })
          ## dev tools
          (cE View, {
            style: ss.scroll_pad
            },
            (cE Title, {
              text: 'DEV tools'
              })
          )
          # gradle
          (cE AboutItem, {
            name: 'gradle'
            url: 'https://gradle.org/'
            })
          # node.js (npm)
          (cE AboutItem, {
            name: 'node.js'
            url: 'https://nodejs.org/en/'
            })
          (cE AboutItem, {
            name: 'npm'
            url: 'https://www.npmjs.com/'
            })
          # yarn
          (cE AboutItem, {
            name: 'yarn'
            url: 'https://yarnpkg.com/en/'
            })
          ## npm packages
          (cE View, {
            style: ss.scroll_pad
            },
            (cE Title, {
              text: 'NPM packages'
              })
          )
          # react-navigation
          (cE AboutItem, {
            name: 'react-navigation'
            url: 'https://reactnavigation.org/'
            })
          # react-redux
          (cE AboutItem, {
            name: 'react-redux'
            url: 'https://github.com/reactjs/react-redux'
            })
          # redux-thunk
          (cE AboutItem, {
            name: 'redux-thunk'
            url: 'https://github.com/gaearon/redux-thunk'
            })
          # events
          (cE AboutItem, {
            name: 'events'
            url: 'https://www.npmjs.com/package/events'
            })
        )
      )
    )
}
PageAbout.navigationOptions = {
  header: null
}

module.exports = PageAbout
