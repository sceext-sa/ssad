# p_welcome.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_welcome

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'PWelcome'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'page p_welcome'
      },
      (cE NavTop, {
        title: 'Welcome to SSAD todo'
        })
      (cE 'div', {
        className: 'page_body'
        },
        # TODO
      )
    )
}

module.exports = Page
