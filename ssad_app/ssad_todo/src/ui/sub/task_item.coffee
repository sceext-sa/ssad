# task_item.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_task_item


{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

task = require '../../task/task'
time = require '../../time/time'


TaskItem = cC {
  displayName: 'TaskItem'
  propTypes: {
    task_id: PropTypes.number.isRequired
    type: PropTypes.string.isRequired
    status: PropTypes.string.isRequired
    title: PropTypes.string.isRequired
    text: PropTypes.string.isRequired
    last_time: PropTypes.string.isRequired

    on_show_task: PropTypes.func.isRequired
  }

  _on_click: ->
    @props.on_show_task @props.task_id

  render: ->
    last_time = time.print_iso_time_short new Date(@props.last_time)

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
            (task.get_short_task_type @props.type)
          )
          (cE 'span', {
            className: 'status'
            },
            (task.get_short_task_status @props.status)
          )
          (cE 'span', {
            className: 'title'
            },
            "#{@props.title}"
          )
          # last_time
          (cE 'span', {
            className: 'time'
            },
            "#{last_time}"
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
