# p_edit_create_task.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_edit_create_task

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  FormGroup
  ControlLabel
  FormControl
  Alert
  ButtonGroup
  Button
} = require 'react-bootstrap'

NavTop = require '../sub/nav_top'
MainButton = require '../sub/main_button'


Page = cC {
  displayName: 'PEditCreateTask'
  propTypes: {
    is_create_task: PropTypes.bool.isRequired
    task_data: PropTypes.object.isRequired  # state.main.edit_task
    enable_commit: PropTypes.bool  # support check task data

    edit_reset: PropTypes.func.isRequired
    edit_set_type: PropTypes.func.isRequired
    edit_set_title: PropTypes.func.isRequired
    edit_set_desc: PropTypes.func.isRequired
    edit_set_time_planned_start: PropTypes.func.isRequired
    edit_set_time_ddl: PropTypes.func.isRequired
    edit_set_time_duration_limit: PropTypes.func.isRequired
    edit_set_time_interval: PropTypes.func.isRequired
    edit_set_time_base: PropTypes.func.isRequired
    edit_commit: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
  }

  _on_set_type_oneshot: ->
    @props.edit_set_type 'oneshot'
  _on_set_type_regular: ->
    @props.edit_set_type 'regular'
  _on_set_time_base_last: ->
    @props.edit_set_time_base 'last'
  _on_set_time_base_fixed: ->
    @props.edit_set_time_base 'fixed'

  _on_set_title: (event) ->
    @props.edit_set_title event.target.value
  _on_set_desc: (event) ->
    @props.edit_set_desc event.target.value
  _on_set_time_planned_start: (event) ->
    @props.edit_set_time_planned_start event.target.value
  _on_set_time_ddl: (event) ->
    @props.edit_set_time_ddl event.target.value
  _on_set_time_duration_limit: (event) ->
    @props.edit_set_time_duration_limit event.target.value
  _on_set_time_interval: (event) ->
    @props.edit_set_time_interval event.target.value

  render: ->
    if @props.is_create_task
      title = 'Create task'
    else
      title = 'Edit task'

    (cE 'div', {
      className: 'page p_edit_create_task'
      },
      (cE NavTop, {
        title
        on_back: @props.on_nav_back
        },
        (cE 'span', {
          className: 'right_text'
          },
          "#{@props.task_data.task_id}"
        )
      )
      (cE 'div', {
        className: 'page_body'
        },
        # TODO edit_reset ?
        # TODO improve render style ?  (data show method)
        # common task attr
        @_render_task_common()
        # check task type
        (switch @props.task_data.type
          when 'oneshot'
            @_render_task_oneshot()
          when 'regular'
            @_render_task_regular()
          #else: error
        )
        # null-fill
        (cE 'div', { className: 'sub_null_fill' })
        # main button
        (cE MainButton, {
          text: 'OK'
          disabled: (! @props.enable_commit)

          on_click: @props.edit_commit
          })
      )
    )

  _render_task_common: ->
    (cE 'form', {
      className: 'task_common'
      },
      # type
      @_render_type()
      # title
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'Title'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.task_data.title
          placeholder: 'title text'
          onChange: @_on_set_title
          })
      )
      # TODO desc (textarea) ?
      (cE 'div', {
        className: 'desc_text'
        },
        (cE FormGroup, null,
          (cE ControlLabel, null,
            'Description'
          )
          (cE FormControl, {
            type: 'text'
            value: @props.task_data.desc
            placeholder: 'desc text'
            onChange: @_on_set_desc
            })
        )
      )
      # common time attr

      # planned_start
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'time: Planned start'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.task_data.time.planned_start
          placeholder: 'planned_start'
          onChange: @_on_set_time_planned_start
          })
      )
      # ddl
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'time: DDL'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.task_data.time.ddl
          placeholder: 'ddl'
          onChange: @_on_set_time_ddl
          })
      )
      # duration_limit
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'time: Duration limit'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.task_data.time.duration_limit
          placeholder: 'duration_limit'
          onChange: @_on_set_time_duration_limit
          })
      )
    )

  _render_type: ->
    (cE 'div', {
      className: 'select_type'
      },
      (cE 'span', null,
        'type'
      )
      (cE ButtonGroup, null,
        (cE Button, {
          active: (@props.task_data.type is 'oneshot')
          onClick: @_on_set_type_oneshot
          },
          'oneshot'
        )
        (cE Button, {
          active: (@props.task_data.type is 'regular')
          onClick: @_on_set_type_regular
          },
          'regular'
        )
      )
    )

  _render_task_oneshot: ->
    (cE 'form', {
      className: 'task_oneshot'
      },
      # TODO
    )

  _render_task_regular: ->
    (cE 'form', {
      className: 'task_regular'
      },
      # interval
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'time: Interval'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.task_data.time.interval
          placeholder: 'interval'
          onChange: @_on_set_time_interval
          })
      )
      # time_base
      @_render_time_base()
    )

  _render_time_base: ->
    (cE 'div', {
      className: 'select_time_base'
      },
      (cE 'span', null,
        'time_base'  # TODO
      )
      (cE ButtonGroup, null,
        (cE Button, {
          active: (@props.task_data.time_base is 'last')
          onClick: @_on_set_time_base_last
          },
          'last'
        )
        (cE Button, {
          active: (@props.task_data.time_base is 'fixed')
          onClick: @_on_set_time_base_fixed
          },
          'fixed'
        )
      )
    )
}

module.exports = Page
