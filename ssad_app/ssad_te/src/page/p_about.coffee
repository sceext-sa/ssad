# p_about.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_about

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

config = require '../config'
NavTop = require '../sub/nav_top'


PAbout = cC {
  displayName: 'PAbout'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_about'
      },
      (cE NavTop, {
        title: 'About'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        (cE 'span', null,
          config.P_VERSION
        )
        # TODO
      )
    )
}

module.exports = PAbout
