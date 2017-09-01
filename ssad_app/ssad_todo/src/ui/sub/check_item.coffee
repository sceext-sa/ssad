# check_item.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_check_item

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'


CheckItem = cC {
  displayName: 'CheckItem'
  propTypes: {
    text: PropTypes.string.isRequired
    is_selected: PropTypes.bool
    show_off: PropTypes.bool

    on_click: PropTypes.func.isRequired
  }

  render: ->
    c = 'sub_check_item'
    if @props.is_selected
      c += ' selected'

    (cE 'div', {
      className: c
      onClick: @props.on_click
      },
      (cE 'span', {
        className: 'text'
        },
        @props.text
      )
      @_render_right()
    )

  _render_right: ->
    if @props.is_selected
      (cE 'span', {
        className: 'right'
        },
        (cE Glyphicon, {
          glyph: 'ok'
          })
      )
    else if @props.show_off
      (cE 'span', {
        className: 'right'
        },
        'off'
      )
}

module.exports = CheckItem
