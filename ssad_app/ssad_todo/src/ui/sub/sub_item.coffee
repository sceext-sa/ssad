# sub_item.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_item

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


SubItem = cC {
  displayName: 'SubItem'
  propTypes: {
    text: PropTypes.string.isRequired
    text_sec: PropTypes.string

    on_click: PropTypes.func.isRequired
  }

  _render_sec: ->
    if @props.text_sec?
      (cE 'span', {
        className: 'text_sec'
        },
        @props.text_sec
      )

  render: ->
    (cE 'div', {
      className: 'sub_item'
      onClick: @props.on_click
      },
      (cE 'span', {
        className: 'text'
        },
        @props.text
      )
      @_render_sec()
      (cE 'span', {
        className: 'right'
        },
        '>'
      )
    )
}

module.exports = SubItem
