# p_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_edit_create_task

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'PEditCreateTask'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'page p_edit_create_task'
      },
      (cE NavTop, {
        title: 'Create task (TODO)'  # TODO Edit task
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
