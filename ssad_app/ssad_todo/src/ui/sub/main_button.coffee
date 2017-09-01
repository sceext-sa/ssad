# main_button.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_main_button

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


MainButton = cC {
  displayName: 'MainButton'
  propTypes: {
    text: PropTypes.string.isRequired
    right: PropTypes.bool
    disabled: PropTypes.bool

    on_click: PropTypes.func.isRequired
  }

  _render_right: ->
    if @props.right
      (cE 'span', {
        className: 'right'
        },
        '>'
      )

  render: ->
    click = @props.on_click
    c = 'sub_main_button'
    if @props.disabled
      click = null
      c += ' disabled'

    (cE 'div', {
      className: c
      onClick: click
      },
      (cE 'span', {
        className: 'text'
        },
        @props.text
      )
      @_render_right()
    )
}

module.exports = MainButton
