# p_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_enable_task_list

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'

time = require '../../time/time'

TaskItem = require '../sub/task_item'


# css class: sub_task_top
TaskTop = cC {
  displayName: 'TaskTop'
  propTypes: {
    count_before: PropTypes.number.isRequired
    count_current: PropTypes.number.isRequired
    count_err: PropTypes.number.isRequired
    count_ok: PropTypes.number.isRequired
    show_list_name: PropTypes.string.isRequired

    on_change_list: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  _on_change_list_before: ->
    @props.on_change_list 'before'
  _on_change_list_current: ->
    @props.on_change_list 'current'
  _on_change_list_err: ->
    @props.on_change_list 'err'
  _on_change_list_ok: ->
    @props.on_change_list 'ok'

  render: ->
    list_class = {
      before: 'list'
      current: 'list'
      err: 'list'
      ok: 'list'
    }
    list_class[@props.show_list_name] += ' active'

    (cE 'div', {
      className: 'sub_task_top'
      },
      # before_list
      (cE 'div', {
        className: list_class.before
        onClick: @_on_change_list_before
        },
        (cE 'span', {
          className: 'name before'
          },
          '+'
        )
        (cE 'span', {
          className: 'number'
          },
          "#{@props.count_before}"
        )
      )
      # current_list
      (cE 'div', {
        className: list_class.current
        onClick: @_on_change_list_current
        },
        (cE 'span', {
          className: 'name current'
          },
          '->'
        )
        (cE 'span', {
          className: 'number'
          },
          "#{@props.count_current}"
        )
      )
      # err_list
      (cE 'div', {
        className: list_class.err
        onClick: @_on_change_list_err
        },
        (cE 'span', {
          className: 'name'
          },
          (cE Glyphicon, {
            glyph: 'remove'
            })
        )
        (cE 'span', {
          className: 'number'
          },
          "#{@props.count_err}"
        )
      )
      # ok_list
      (cE 'div', {
        className: list_class.ok
        onClick: @_on_change_list_ok
        },
        (cE 'span', {
          className: 'name'
          },
          (cE Glyphicon, {
            glyph: 'ok'
            })
        )
        (cE 'span', {
          className: 'number'
          },
          "#{@props.count_ok}"
        )
      )
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
    task: PropTypes.object  # task data
    show_list: PropTypes.array.isRequired  # task items to show

    count_before: PropTypes.number.isRequired  # before_list items count
    count_current: PropTypes.number.isRequired  # current_list items count
    count_err: PropTypes.number.isRequired  # err_list items count
    count_ok: PropTypes.number.isRequired  # ok_list items count
    show_list_name: PropTypes.string.isRequired

    on_show_item: PropTypes.func.isRequired

    on_change_list: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_enable_task_list'
      },
      (cE TaskTop, {
        count_before: @props.count_before
        count_current: @props.count_current
        count_err: @props.count_err
        count_ok: @props.count_ok
        show_list_name: @props.show_list_name

        on_change_list: @props.on_change_list
        on_nav_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # show list
        @_render_show_list()
      )
    )

  _render_show_list: ->
    # check render placeholder
    count = 0
    for i in @props.show_list
      count += i[1].length
    if count < 1
      return @_render_placeholder()

    o = []
    for i in @props.show_list
      # not render empty list
      if i[1].length > 0
        o.push @_render_one_list(i)
    o

  _render_placeholder: ->
    (cE 'div', {
      className: 'placeholder'
      },
      (cE 'span', null,
        'no item'
      )
    )

  _get_last_time: (group_name, one) ->
    o = time.print_iso_time_short new Date(one.calc.last_time)
    switch group_name
      when 'wait', 'ready'  # show planned_start
        ps = one.calc.planned_start
        if ps? and (ps.trim() != '')
          d = new Date(ps)
          if ! Number.isNaN d.getTime()  # good iso string
            # print planned_start
            o = "#{time.print_iso_time_short d} ~"
      when 'doing', 'paused'  # show ddl
        ddl = one.calc.ddl
        if ddl? and (ddl.trim() != '')
          d = new Date(ddl)
          if ! Number.isNaN d.getTime()
            o = "~ #{time.print_iso_time_short d}"
      when 'cancel', 'fail', 'done'  # show last_end
        o = ":: #{time.print_iso_time_short new Date(one.calc.last_end), true, false, true}"
      #else: show default: last_time
    o

  _render_one_list: (data) ->
    group_name = data[0]
    # render each task item
    o = []
    for i in data[1]
      one = @props.task[i]

      o.push (cE TaskItem, {
        key: i

        task_id: i
        type: one.raw.data.type
        status: one.calc.status
        title: one.raw.data.title
        text: one.calc.text
        last_time: @_get_last_time group_name, one

        on_show_task: @props.on_show_item
      })
    # one list
    (cE 'div', {
      className: 'show_list'
      key: group_name
      },
      (cE 'span', {
        className: 'name'
        },
        "#{group_name}"
      )
      o  # task_item list
    )
}

module.exports = Page
