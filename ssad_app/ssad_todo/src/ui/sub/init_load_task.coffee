# init_load_task.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_init_load_task

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  ProgressBar
} = require 'react-bootstrap'


InitLoadTask = cC {
  displayName: 'InitLoadTask'
  propTypes: {
    now: PropTypes.number.isRequired
    all: PropTypes.number.isRequired
    task_id: PropTypes.string.isRequired
  }

  _calc_now: ->
    if @props.all < 1
      0
    else
      (@props.now / @props.all) * 100

  _gen_label: ->
    "#{@props.now} / #{@props.all}"

  render: ->
    (cE 'div', {
      className: 'sub_init_load_task'
      },
      (cE 'div', {
        className: 'text'
        },
        (cE 'span', null,
          "SSAD_todo is loading tasks .. . (task_id #{@props.task_id})"
        )
      )
      (cE ProgressBar, {
        active: true
        now: @_calc_now()
        label: @_gen_label()
        })
    )
}

module.exports = InitLoadTask
