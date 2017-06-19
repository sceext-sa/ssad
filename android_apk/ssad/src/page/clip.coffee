# clip.coffee, ssad/android_apk/ssad/src/page/

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

NavHeader = require '../sub/nav_header'
TextArea = require '../sub/text_area'

btn = require '../sub/btn'
config = require '../config'
ssad_native = require '../ssad_native'


PageClip = cC {
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
    # TODO
    if @state.disable_main_button
      @setState {
        disable_main_button: false
      }

  _on_start_service: ->
    @setState {
      disable_main_button: true
    }
    await ssad_native.start_service 'clip_service'

  _on_stop_service: ->
    @setState {
      disable_main_button: true
    }
    await ssad_native.stop_service 'clip_service'

  componentDidMount: ->
    await @_update_status()
    # add event listeners
    ssad_native.event_listener().on 'service_started', @_update_status
    ssad_native.event_listener().on 'service_stopped', @_update_status

  componentWillUnmount: ->
    # remove event listeners
    ssad_native.event_listener().removeListener 'service_started', @_update_status
    ssad_native.event_listener().removeListener 'service_stopped', @_update_status

  render: ->
    service_status = '(unknow)'
    if @state.status?
      if @state.status.service_running_clip
        service_status = 'Clip service is running '
      else
        service_status = 'Clip service NOT running'

    (cE View, {
      style: {
        flex: 1
      } },
      (cE ScrollView, {
        style: ss.scroll
        contentContainerStyle: [ ss.box, ss.scroll_in ]
        },
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 1
          } ]
          },
          # clip service status
          (cE TextArea, {
            text: service_status
            })
        )
        # start/stop service button
        @_render_main_button()
      )
    )

  _render_main_button: ->
    if ! @state.status?
      return null
    if @state.status.service_running_clip
      (cE btn.BigDangerButton, {
        text: 'Stop service'
        no_margin: true
        on_click: @_on_stop_service
        disabled: @state.disabled_main_button
        })
    else
      (cE btn.BigPrimaryButton, {
        text: 'Start service'
        no_margin: true
        on_click: @_on_start_service
        disabled: @state.disabled_main_button
        })
}
PageClip.navigationOptions = {
  header: (props) ->
    (cE NavHeader, {
      title: 'SSAD Clip'
      header_props: props
      })
}

module.exports = PageClip
