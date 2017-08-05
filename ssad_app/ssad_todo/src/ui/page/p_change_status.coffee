# p_change_status.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_change_status

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'PChangeStatus'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'page p_change_status'
      },
      (cE NavTop, {
        title: 'Change status'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # TODO
      )
    )
}

module.exports = Page
