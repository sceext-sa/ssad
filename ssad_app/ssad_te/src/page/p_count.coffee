# p_count.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_count

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PCount = cC {
  displayName: 'PCount'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_count'
      },
      (cE NavTop, {
        title: 'Count'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PCount
