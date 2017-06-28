# p_file.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_file

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PFile = cC {
  displayName: 'PFile'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_file'
      },
      (cE NavTop, {
        title: 'File'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PFile
