# service.coffee, ssad/android_apk/ssad/src/page/

{
  createClass: cC
  createElement: cE
} = require 'react'
{ View } = require 'react-native'

ss = require '../style/ss'

NavHeader = require '../sub/nav_header'
FullScroll = require '../sub/full_scroll'
Title = require '../sub/title'
P = require '../sub/p'
TextArea = require '../sub/text_area'
UrlLink = require '../sub/url_link'

NotImplemented = require '../sub/not_implemented'

btn = require '../sub/btn'


PageService = cC {
  # TODO support ssad_server log (DEBUG) ?

  _server_status: ->
    o = 'ssad_server NOT running'
    if @props.is_server_running
      o = 'ssad_server is running'
    o

  _clip_status: ->
    o = 'Clip service NOT running'
    if @props.is_clip_running
      o = 'Clip service is running'
    o

  _render_open_url: ->
    if @props.is_server_running
      (cE UrlLink, {
        url: "http://127.0.0.1:#{@props.server_port}/"
        })

  _render_server_button: ->
    if ! @props.is_server_running?
      return null
    if @props.is_server_running
      (cE btn.BigDangerButton, {
        text: 'Stop server'
        no_margin: true
        on_click: @props.on_stop_server
        disabled: @props.disable_server_button
        })
    else
      (cE btn.BigPrimaryButton, {
        text: 'Start server'
        no_margin: true
        on_click: @props.on_start_server
        disabled: @props.disable_server_button
        })

  _render_clip_button: ->
    if ! @props.is_clip_running?
      return null
    if @props.is_clip_running
      (cE btn.BigDangerButton, {
        text: 'Stop clip'
        no_margin: true
        on_click: @props.on_stop_clip
        disabled: @props.disable_clip_button
        })
    else
      (cE btn.BigPrimaryButton, {
        text: 'Start clip'
        no_margin: true
        on_click: @props.on_start_clip
        disabled: @props.disable_clip_button
        })

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE NavHeader, {
        title: 'Services'
        navigation: @props.navigation
        })
      (cE FullScroll, null,
        # ssad_server service
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 1
          } ]
          },
          (cE Title, {
            text: 'ssad_server'
            })
          (cE TextArea, {
            text: @_server_status()
            })
          # open url link
          @_render_open_url()
          # TODO server log ?
          (cE NotImplemented)
        )
        @_render_server_button()
        # clip service
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 0
          } ]
          },
          (cE Title, {
            text: 'SSAD clip'
            })
          (cE TextArea, {
            text: @_clip_status()
            })
        )
        @_render_clip_button()
      )
    )
}
PageService.navigationOptions = {
  header: null
}

module.exports = PageService
