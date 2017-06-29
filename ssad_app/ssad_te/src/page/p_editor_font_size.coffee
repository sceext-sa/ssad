# p_editor_font_size.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor_font_size

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PEditorFontSize = cC {
  displayName: 'PEditorFontSize'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_editor_font_size'
      },
      (cE NavTop, {
        title: 'Font size'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PEditorFontSize
