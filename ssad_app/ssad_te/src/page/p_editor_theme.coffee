# p_editor_theme.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor_theme

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PEditorTheme = cC {
  displayName: 'PEditorTheme'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_editor_theme'
      },
      (cE NavTop, {
        title: 'Theme'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PEditorTheme
