# setting.coffee, ssad/android_apk/ssad/src/page/

{
  createClass: cC
  createElement: cE
} = require 'react'
{ View } = require 'react-native'

ss = require '../style/ss'

NavHeader = require '../sub/nav_header'
FullScroll = require '../sub/full_scroll'
NullFill = require '../sub/null_fill'
Title = require '../sub/title'
Hr = require '../sub/hr'
P = require '../sub/p'
TextArea = require '../sub/text_area'
Input = require '../sub/input'

btn = require '../sub/btn'

PageSetting = cC {
  render: ->
    reset = 'reset'
    if ! @props.show_save_button
      reset = null

    (cE View, {
      style: {
        flex: 1
      } },
      (cE NavHeader, {
        title: 'Settings'
        navigation: @props.navigation
        right: reset
        on_click_right: @props.on_reset
        })
      (cE FullScroll, null,
        # ssad_server config
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 0
          } ]
          },
          (cE Title, {
            text: 'ssad_server'
            })
          (cE View, {
            style: {
              flexDirection: 'row'
              alignItems: 'center'
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
                value: @props.port
                right: true
                on_change: @props.on_change_port
                })
            )
          )
        )
        # root-key
        (cE Hr)
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 0
          } ]
          },
          (cE View, {
            style: {
              flexDirection: 'row'
            } },
            (cE View, {
              style: {
                flex: 1
              } },
              (cE P, {
                text: 'root key'
                })
            )
            # make root-key button
            (cE btn.Button, {
              text: 'make'
              on_click: @props.on_make_root_key
              })
          )
          (cE TextArea, {
            selectable: true
            sec: true
            text: @props.root_key
            })
        )
        # root app
        (cE Hr)
        (cE View, {
          style: [ ss.scroll_pad, {
            flex: 0
            paddingBottom: 10
          } ]
          },
          (cE P, {
            text: 'root app'
            })
          (cE View, {
            style: {
              flexDirection: 'row'
            } },
            (cE Input, {
              value: @props.root_app
              on_change: @props.on_change_root_app
              })
          )
          # TODO init config files for ssad_server ?  (in /sdcard/ )
        )
        (cE NullFill)
        # save config (main button)
        @_render_save_button()
      )
    )

  _render_save_button: ->
    if @props.show_save_button
      (cE btn.BigPrimaryButton, {
        text: 'Save'
        no_margin: true
        on_click: @props.on_save
        })
}
PageSetting.navigationOptions = {
  header: null
}

module.exports = PageSetting
