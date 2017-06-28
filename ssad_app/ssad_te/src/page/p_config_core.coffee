# p_config_core.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_config_core

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PConfigCore = cC {
  displayName: 'PConfigCore'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_config_core'
      },
      (cE NavTop, {
        title: 'Core editor'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PConfigCore
