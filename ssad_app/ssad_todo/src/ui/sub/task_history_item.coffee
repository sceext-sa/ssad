# task_history_item.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_task_history_item


{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

time = require '../../time/time'


TaskHistoryItem = cC {
  displayName: 'TaskHistoryItem'
  propTypes: {
    mode: PropTypes.string
    # available mode:
    # + default (null): normal show history items
    # + 'hide_group': title of hide_group
    # + 'hide_show': show item under hide
    # + 'create': create task history
    # + 'load_more': load more button

    # for default/hide_show/create mode  (_time is history_name)
    history: PropTypes.object  # history data: _time, status, comment

    is_group_show: PropTypes.bool  # for hide_group mode
    group_size: PropTypes.number  # for hide_group mode

    on_hide_history: PropTypes.func  # for default mode
    on_show_history: PropTypes.func  # for hide_show mode
    on_show_group: PropTypes.func  # for hide_group mode
    on_hide_group: PropTypes.func  # for hide_group mode

    on_load_more: PropTypes.func  # for load_more mode
  }

  render: ->
    (cE 'div', {
      className: 'sub_task_history_item'
      },
      @_render_mode()
    )

  _render_mode: ->
    switch @props.mode
      when 'hide_group'
        @_render_hide_group()
      when 'hide_show'
        @_render_hide_show()
      when 'create'
        @_render_create()
      when 'load_more'
        @_render_load_more()
      else  # default mode
        @_render_default()

  _render_left_button: (class_name, text, callback) ->
    (cE 'div', {
      className: "left_button #{class_name}"
      onClick: callback
      },
      (cE 'span', null,
        "#{text}"
      )
    )

  _render_time: ->
    time_str = time.print_iso_time_short new Date(@props.history._time), true, true
    (cE 'div', {
      className: 'time'
      },
      (cE 'span', null,
        "#{time_str}"
      )
    )

  _render_content: ->
    s = null
    c = null
    # status
    if @props.history.data.status?
      s = (cE 'span', {
        className: 'status'
        },
        "status: #{@props.history.data.status}"
      )
    # comment
    if @props.history.data.note?
      c = (cE 'span', {
        className: 'comment'
        },
        "#{@props.history.data.note}"
      )
    (cE 'div', {
      className: 'content'
      },
      s
      c
    )

  _render_default: ->
    (cE 'div', {
      className: 'mode default'
      },
      @_render_left_button('', '', @props.on_hide_history)
      @_render_time()
      @_render_content()
    )

  _render_hide_show: ->
    (cE 'div', {
      className: 'mode hide_show'
      },
      @_render_left_button('', 'H', @props.on_show_history)
      @_render_time()
      @_render_content()
    )

  _render_hide_group: ->
    if @props.is_group_show
      text = '-'
      class_name = 'mode hide_group show'
      callback = @props.on_hide_group
    else
      text = "#{@props.group_size}"
      class_name = 'mode hide_group'
      callback = @props.on_show_group

    (cE 'div', {
      className: class_name
      },
      @_render_left_button('', text, callback)
    )

  _render_create: ->
    create_time = time.print_iso_time_short new Date(@props.history._time), true, true
    (cE 'div', {
      className: 'mode last_item create'
      },
      (cE 'span', null,
        "Created at #{create_time}"
      )
    )

  _render_load_more: ->
    (cE 'div', {
      className: 'mode last_item load_more'
      onClick: @props.on_load_more
      },
      (cE 'span', null,
        'load more'
      )
    )
}

module.exports = TaskHistoryItem
