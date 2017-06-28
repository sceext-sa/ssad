# p_main.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_main

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PMain = cC {
  displayName: 'PMain'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_main'
      },
      (cE NavTop, {
        title: 'Text Editor on SSAD'
        title_center: true
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PMain
