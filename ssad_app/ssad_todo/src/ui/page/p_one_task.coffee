# p_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_one_task

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'POneTask'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'page p_one_task'
      },
      (cE NavTop, {
        title: 'One task (TODO)'  # TODO more info about the task
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
