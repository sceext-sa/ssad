# add_button.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_add_button

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


AddButton = cC {
  displayName: 'AddButton'
  propTypes: {
    on_click: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'sub_add_button'
      onClick: @props.on_click
      },
      (cE 'span', null,
        '+'
      )
    )
}

module.exports = AddButton
