# p_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_enable_task_list

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'PEnableTaskList'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'page p_enable_task_list'
      },
      # TODO not use NavTop ?
      (cE NavTop, {
        title: 'TODO'
        # TODO
        })
      (cE 'div', {
        className: 'page_body'
        },
        # TODO
      )
    )
}

module.exports = Page
