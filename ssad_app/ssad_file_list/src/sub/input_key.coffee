# input_key.coffee, ssad/ssad_app/ssad_file_list/src/sub/
# css class: sub_input_key

{ createElement: cE } = require 'react'
cC = require 'create-react-class'

Input = require './input'

btn = require './btn'


InputKey = cC {
  displayName: 'InputKey'

  _render_error: ->
    if @props.error
      (cE 'p', {
        className: 'error'
        },
        @props.error
      )

  render: ->
    (cE 'div', {
      className: 'sub_input_key'
      },
      (cE 'p', null,
        'APP_ID'
      )
      (cE Input, {
        value: @props.input.id
        on_change: @props.on_change_id
        })
      (cE 'p', null,
        'SSAD_KEY'
      )
      (cE Input, {
        value: @props.input.key
        on_change: @props.on_change_key
        })
      @_render_error()
      (cE btn.Button, {
        text: 'OK'
        on_click: @props.on_save_config
        })
    )
}

module.exports = InputKey
