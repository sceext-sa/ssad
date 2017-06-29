# main_button.coffee, ssad/ssad_app/ssad_te/src/sub/
# css class: sub_main_button

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


MainButton = cC {
  displayName: 'MainButton'
  propTypes: {
    text: PropTypes.string.isRequired

    on_click: PropTypes.func
  }

  _on_click: ->
    @props.on_click?()

  render: ->
    (cE 'div', {
      className: 'sub_main_button'
      onClick: @_on_click
      },
      (cE 'span', null,
        @props.text
      )
    )
}

module.exports = MainButton
