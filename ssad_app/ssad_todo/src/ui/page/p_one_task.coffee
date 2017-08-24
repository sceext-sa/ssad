# p_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_one_task

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'

task = require '../../task/task'
time = require '../../time/time'

NavTop = require '../sub/nav_top'


Page = cC {
  displayName: 'POneTask'
  propTypes: {
    task_id: PropTypes.number.isRequired
    data: PropTypes.object  # task data
    show_detail: PropTypes.bool.isRequired
    history_list: PropTypes.array  # history items to show
    can_load_more_history: PropTypes.bool.isRequired

    on_edit_task: PropTypes.func.isRequired
    on_change_status: PropTypes.func.isRequired
    on_change_show_detail: PropTypes.func.isRequired
    on_load_more_history: PropTypes.func.isRequired
    on_hide_history: PropTypes.func.isRequired
    on_show_history: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
  }

  _on_show_detail: ->
    @props.on_change_show_detail true

  _on_hide_detail: ->
    @props.on_change_show_detail false

  _render_top: ->
    task_type = null
    task_status = null
    if @props.data?
      task_type = task.get_short_task_type @props.data.raw.data.type
      task_status = task.get_short_task_status @props.data.status

    (cE 'div', {
      className: 'one_task_top'
      },
      # left part
      (cE 'div', {
        className: 'left'
        onClick: @props.on_change_status
        },
        # task type/status
        (cE 'span', {
          className: 'type'
          },
          "#{task_type}"
        )
        (cE 'span', {
          className: 'status'
          },
          "#{task_status}"
        )
        # TODO time ?
      )
      # right
      (cE 'div', {
        className: 'right'
        onClick: @props.on_edit_task
        },
        # task_id
        (cE 'span', {
          className: 'task_id'
          },
          "#{@props.task_id}"
        )
        # edit mark
        (cE 'span', {
          className: 'edit'
          },
          (cE Glyphicon, {
            glyph: 'pencil'
            })
        )
      )
    )

  render: ->
    (cE 'div', {
      className: 'page p_one_task'
      },
      (cE NavTop, {
        # no title
        on_back: @props.on_nav_back
        },
        @_render_top()
      )
      (cE 'div', {
        className: 'page_body'
        },
        @_render_task()
      )
    )

  _render_task: ->
    # not renter if no data
    if ! @props.data?
      return null

    (cE 'div', {
      className: 'task'
      },
      @_render_task_common()
      @_render_task_detail()
      @_render_detail_button()
      # task history
      @_render_history()
    )

  _render_info_item: (name, value) ->
    if ! value?
      return null

    (cE 'div', {
      className: 'item'
      },
      (cE 'span', {
        className: 'name'
        },
        "#{name}"
      )
      (cE 'span', {
        className: 'value'
        },
        "#{value}"
      )
    )

  _render_time_attr: (name, raw) ->
    if (! raw?) or (raw.trim() is '')
      return null
    @_render_info_item name, time.print_time(time.parse_time_str(raw))

  _render_task_common: ->
    raw = @props.data.raw
    # task type: regular or oneshot
    switch raw.data.type
      when 'regular'
        p = @_render_time_attr 'Interval', raw.data.time.interval
      when 'oneshot'
        # TODO or use ddl ?
        p = @_render_time_attr 'Planned start', raw.data.time.planned_start

    (cE 'div', {
      className: 'common'
      },
      # title
      (cE 'span', {
        className: 'title'
        },
        "#{raw.data.title}"
      )
      # desc
      (cE 'span', {
        className: 'desc'
        },
        "#{raw.data.desc}"
      )
      # TODO time ?
      p  # oneshot / regular
    )

  _render_detail_button: ->
    if @props.show_detail
      icon = 'menu-up'
      callback = @_on_hide_detail
    else
      icon = 'menu-down'
      callback = @_on_show_detail

    (cE 'div', {
      className: 'detail_button'
      onClick: callback
      },
      (cE 'span', {
        className: 'icon'
        },
        (cE Glyphicon, {
          glyph: icon
          })
      )
    )

  _render_task_detail: ->
    if ! @props.show_detail
      return null
    raw = @props.data.raw

    that = this
    _planned_start = ->
      if raw.data.type is 'oneshot'
        return null
      that._render_time_attr 'Planned start', raw.data.time.planned_start
    _time_base = ->
      if raw.data.type is 'oneshot'
        return null
      that._render_info_item 'Time base', raw.data.time_base

    last_update = time.print_iso_time_short new Date(raw._time)

    (cE 'div', {
      className: 'detail'
      },
      # planned_start (only for regular task)
      _planned_start()
      # ddl
      @_render_time_attr 'DDL', raw.data.time.ddl
      # duration_limit
      @_render_time_attr 'Duration limit', raw.data.time.duration_limit
      # time_base for regular
      _time_base()

      # last_update (edit_task)
      (cE 'span', {
        className: 'last_update'
        },
        "#{last_update}"
      )
    )

  _render_history: ->
    # TODO
}

module.exports = Page
