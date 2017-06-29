# p_editor_mode.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor_mode

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PEditorMode = cC {
  displayName: 'PEditorMode'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_editor_mode'
      },
      (cE NavTop, {
        title: 'Mode'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PEditorMode
