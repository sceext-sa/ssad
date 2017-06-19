# about.coffee, ssad/android_apk/ssad/src/page/

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

NavHeader = require '../sub/nav_header'
Title = require '../sub/title'
P = require '../sub/p'
TextArea = require '../sub/text_area'
UrlLink = require '../sub/url_link'

config = require '../config'
ssad_native = require '../ssad_native'

PageAbout = cC {
  render: ->
    version_info = ssad_native.version()
    v = config.P_VERSION + '\n'
    v += version_info.ssad_native + '\n'
    v += version_info.ssad_server + '\n'
    v += version_info.http_server + '\n'

    (cE ScrollView, {
      style: ss.scroll
      contentContainerStyle: [ ss.box, ss.scroll_in, ss.scroll_pad ]
      },
      # ssad version
      (cE Title, {
        text: 'SSA Daemon'
        })
      (cE P, {
        text: v
        })
      # homepage of ssad
      (cE UrlLink, {
        url: 'https://github.com/sceext-sa/ssad'
        })
      # technologies (library/framework) used in this program
      (cE Title, {
        text: 'Technologies'
        })
      # TODO
      (cE TextArea, {
        text: 'TODO'
        })
    )
}
PageAbout.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'About'
      header_props: props
      })
}

module.exports = PageAbout
