# p_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_enable_task_list

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'


# css class: sub_task_top
TaskTop = cC {
  displayName: 'TaskTop'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'sub_task_top'
      },
      # TODO
      (cE 'span', {
        className: 'todo'
        },
        'TODO'
      )
      # TODO
      # right button (for open main menu)
      (cE 'span', {
        className: 'main_menu'
        onClick: @props.on_nav_back
        },
        (cE Glyphicon, {
          glyph: 'option-vertical'
          })
      )
    )
}


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
      (cE TaskTop, {
        # TODO

        on_nav_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # TODO
      )
    )
}

module.exports = Page
