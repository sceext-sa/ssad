# input.coffee, ssad/ssad_app/ssad_file_list/src/sub/
# css class: sub_input

{ createElement: cE } = require 'react'
cC = require 'create-react-class'


Input = cC {
  displayName: 'Input'

  _on_change: (event) ->
    @props.on_change?(event.target.value)

  render: ->
    (cE 'div', {
      className: 'sub_input'
      },
      (cE 'input', {
        type: 'text'
        value: @props.value
        onChange: @_on_change
        })
    )
}

module.exports = Input
