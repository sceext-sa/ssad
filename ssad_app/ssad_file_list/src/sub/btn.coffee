# btn.coffee, ssad/ssad_app/ssad_file_list/src/sub/
# css class: sub_btn

{ createElement: cE } = require 'react'
cC = require 'create-react-class'


Button = cC {
  displayName: 'Button'

  render: ->
    (cE 'div', {
      className: 'sub_btn'
      },
      (cE 'button', {
        type: 'button'
        onClick: @props.on_click
        },
        @props.text
      )
    )
}

module.exports = {
  Button
}
