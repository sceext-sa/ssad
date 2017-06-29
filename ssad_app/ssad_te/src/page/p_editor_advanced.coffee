# p_editor_advanced.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor_advanced

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PEditorAdvanced = cC {
  displayName: 'PEditorAdvanced'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_editor_advanced'
      },
      (cE NavTop, {
        title: 'Advanced'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PEditorAdvanced
