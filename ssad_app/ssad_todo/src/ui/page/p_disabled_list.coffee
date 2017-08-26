# p_disabled_list.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_disabled_list

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
TaskItem = require '../sub/task_item'
MainButton = require '../sub/main_button'


Page = cC {
  displayName: 'PDisabledList'
  propTypes: {
    count_all: PropTypes.number.isRequired  # number of all disabled tasks
    count_loaded: PropTypes.number.isRequired  # loaded disabled tasks

    task: PropTypes.object  # task data
    show_list: PropTypes.array.isRequired  # task items to show
    di: PropTypes.object.isRequired  # disabled index

    on_show_item: PropTypes.func.isRequired
    on_load_more: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_disabled_list'
      },
      (cE NavTop, {
        title: 'Disabled'
        on_back: @props.on_nav_back
        },
        # count
        (cE 'span', {
          className: 'top_count'
          },
          "#{@props.count_loaded} / #{@props.count_all}"
        )
      )
      (cE 'div', {
        className: 'page_body'
        },
        @_render_body()
        @_render_load_more()
      )
    )

  _render_body: ->
    if @props.show_list.length < 1
      # placeholder
      return (cE 'div', {
        className: 'placeholder'
        },
        (cE 'span', null,
          'no item'
        )
      )
    o = []
    # render each item
    for i in @props.show_list
      one = @props.task[i]
      if one?
        o.push (cE TaskItem, {
          key: i

          task_id: Number.parseInt i
          type: one.raw.data.type
          status: one.status
          title: one.raw.data.title
          text: one.text
          last_time: @props.di[i]  # use disabled time as time

          on_show_task: @props.on_show_item
        })
    o

  _render_load_more: ->
    if @props.count_loaded >= @props.count_all
      return

    (cE MainButton, {
      text: 'load more'
      on_click: @props.on_load_more
    })
}

module.exports = Page
