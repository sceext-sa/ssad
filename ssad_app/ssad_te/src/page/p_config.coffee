# p_config.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_config

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PConfig = cC {
  displayName: 'PConfig'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_config'
      },
      (cE NavTop, {
        title: 'Config'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PConfig
