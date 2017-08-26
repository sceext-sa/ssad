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
TaskHistoryItem = require '../sub/task_history_item'


Page = cC {
  displayName: 'POneTask'
  propTypes: {
    task_id: PropTypes.number
    data: PropTypes.object  # task data
    show_detail: PropTypes.bool.isRequired
    can_load_more_history: PropTypes.bool.isRequired

    group: PropTypes.array  # history of groups to show

    on_edit_task: PropTypes.func.isRequired
    on_change_status: PropTypes.func.isRequired
    on_change_show_detail: PropTypes.func.isRequired

    on_load_more_history: PropTypes.func.isRequired

    on_hide_history: PropTypes.func.isRequired
    on_show_history: PropTypes.func.isRequired
    on_hide_history_group: PropTypes.func.isRequired
    on_show_history_group: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
  }

  _on_show_detail: ->
    @props.on_change_show_detail true

  _on_hide_detail: ->
    @props.on_change_show_detail false

  _render_top: ->
    task_type = null
    task_status = null
    long_status = ''
    if @props.data?
      task_type = task.get_short_task_type @props.data.raw.data.type
      long_status = @props.data.status
      task_status = task.get_short_task_status long_status

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
        # current long status
        (cE 'span', {
          className: 'long_status'
          },
          "#{long_status}"
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
      p  # oneshot / regular
      # auto_ready
      (@_render_time_attr 'Auto ready', raw.data.time.auto_ready)
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

    last_update = time.print_iso_time_short new Date(raw._time), true, true

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

  _render_no_history: ->
    (cE 'div', {
      className: 'no_history'
      },
      (cE 'span', null,
        'no history loaded for disabled task'
      )
    )

  _render_history: ->
    # check task disabled
    if @props.data.disabled
      return @_render_no_history()

    groups = []
    for i in [0... @props.group.length]
      groups.push @_render_one_group(i, @props.group[i])

    (cE 'div', {
      className: 'all_history'
      },
      groups
      @_render_load_more()
    )

  _render_one_group: (group_id, group) ->
    class_name = 'one_group'
    group_title = null
    group_body = null
    show_group_body = false
    # check hide or show group
    if group.hide  # a hide group
      class_name += ' hide_group'
      group_title = @_render_group_title group_id, group
      # check hide_show
      if group.hide_show
        show_group_body = true
    else
      show_group_body = true
    # render group_body: history items
    if show_group_body
      group_body = []
      for history_name in group.history
        group_body.push @_render_one_item(group_id, group, history_name)
    # FIXME type: 'create' history can not be hide !

    (cE 'div', {
      key: group_id

      className: class_name
      },
      group_title
      group_body
    )

  _render_one_item: (group_id, group, history_name) ->
    # check is create history
    history = @props.data.history[history_name]
    if history.data.type is 'create'
      return @_render_create_history group_id, group, history

    mode = null  # default mode
    if group.hide
      mode = 'hide_show'

    that = this
    on_hide_history = ->
      that.props.on_hide_history that.props.task_id, history_name
    on_show_history = ->
      that.props.on_show_history that.props.task_id, history_name

    (cE TaskHistoryItem, {
      key: history_name

      mode
      history

      on_hide_history
      on_show_history
    })

  _render_group_title: (group_id, group) ->
    that = this
    on_show_group = ->
      that.props.on_show_history_group that.props.task_id, group_id
    on_hide_group = ->
      that.props.on_hide_history_group that.props.task_id, group_id

    (cE TaskHistoryItem, {
      mode: 'hide_group'

      is_group_show: group.hide_show
      group_size: group.history.length

      on_show_group
      on_hide_group
    })

  _render_create_history: (group_id, group, history) ->
    # TODO support show comment/status with create history ?
    (cE TaskHistoryItem, {
      key: history._time

      mode: 'create'
      history
    })

  _render_load_more: ->
    if ! @props.can_load_more_history
      return null

    that = this
    on_load_more = ->
      that.props.on_load_more_history that.props.task_id

    (cE TaskHistoryItem, {
      mode: 'load_more'

      on_load_more
    })
}

module.exports = Page
