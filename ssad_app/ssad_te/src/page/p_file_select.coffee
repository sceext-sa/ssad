# p_file_select.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_file_select

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PFileSelect = cC {
  displayName: 'PFileSelect'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_file_select'
      },
      (cE NavTop, {
        title: 'Select'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PFileSelect
