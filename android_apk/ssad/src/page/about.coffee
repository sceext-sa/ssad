# about.coffee, ssad/android_apk/ssad/src/page/

{
  createClass: cC
  createElement: cE
} = require 'react'
{
  View
  ScrollView
} = require 'react-native'

ss = require '../style/ss'

NavHeader = require '../sub/nav_header'
FullScroll = require '../sub/full_scroll'
Title = require '../sub/title'
P = require '../sub/p'
TextArea = require '../sub/text_area'
UrlLink = require '../sub/url_link'

config = require '../config'
ssad_native = require '../ssad_native'

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
          style: [ ss.box, ss.scroll_pad ]
          },
          (cE View, {
            style: {
              flex: 0
            } },
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
          )
          (cE View, {
            style: {
              flex: 1
            } },
            # technologies (library/framework) used in this program
            (cE Title, {
              text: 'Technologies'
              })
            # TODO
            (cE TextArea, {
              text: 'TODO'
              })
          )
        )
      )
    )
}
PageAbout.navigationOptions = {
  header: null
}

module.exports = PageAbout
