# task_item.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_task_item


{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


TaskItem = cC {
  displayName: 'TaskItem'
  propTypes: {
    task_id: PropTypes.number.isRequired
    type: PropTypes.string.isRequired
    status: PropTypes.string.isRequired
    title: PropTypes.string.isRequired
    text: PropTypes.string.isRequired
    # TODO time/ddl ?
    on_show_task: PropTypes.func.isRequired
  }

  _TASK_TYPE: {
    'oneshot': 'o'
    'regular': 'r'
  }
  _TASK_STATUS: {
    'init': 'I'
    'wait': 'W'
    'doing': 'D'
    'paused': 'P'
    'done': 'O'
    'fail': 'F'
    'cancel': 'C'
    'disabled': 'S'
  }

  _on_click: ->
    @props.on_show_task @props.task_id

  render: ->
    (cE 'div', {
      className: 'sub_task_item'
      },
      (cE 'div', {
        className: 'left'
        },
        (cE 'div', {
          className: 'up'
          },
          (cE 'span', {
            className: 'type'
            },
            "#{@_TASK_TYPE[@props.type]}"
          )
          (cE 'span', {
            className: 'status'
            },
            "#{@_TASK_STATUS[@props.status]}"
          )
          (cE 'span', {
            className: 'title'
            },
            "#{@props.title}"
          )
          # TODO time/ddl ?
          (cE 'span', {
            className: 'time'
            },
            'TODO'
          )
        )
        (cE 'div', {
          className: 'down'
          },
          (cE 'span', {
            className: 'text'
            },
            "#{@props.text}"
          )
        )
      )
      (cE 'div', {
        className: 'right'
        onClick: @_on_click
        },
        (cE 'span', null,
          '>'
        )
      )
    )
}

module.exports = TaskItem
