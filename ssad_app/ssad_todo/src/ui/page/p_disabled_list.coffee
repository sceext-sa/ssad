# p_disabled_list.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_disabled_list

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'PDisabledList'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'page p_disabled_list'
      },
      (cE NavTop, {
        title: 'Disabled'
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
