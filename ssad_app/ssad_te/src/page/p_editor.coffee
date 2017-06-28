# p_editor.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PEditor = cC {
  displayName: 'PEditor'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_editor'
      },
      (cE NavTop, {
        title: 'Editor'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PEditor
