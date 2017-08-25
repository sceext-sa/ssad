# p_change_status.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_change_status

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  FormGroup
  FormControl
} = require 'react-bootstrap'

NavTop = require '../sub/nav_top'
MainButton = require '../sub/main_button'
CheckItem = require '../sub/check_item'


Page = cC {
  displayName: 'PChangeStatus'
  propTypes: {
    task_id: PropTypes.number
    task_title: PropTypes.string.isRequired

    comment: PropTypes.string.isRequired

    status: PropTypes.string
    disabled: PropTypes.bool.isRequired
    old_status: PropTypes.string.isRequired
    old_disabled: PropTypes.bool.isRequired

    on_set_status: PropTypes.func.isRequired
    on_set_disabled: PropTypes.func.isRequired
    on_set_comment: PropTypes.func.isRequired

    commit_status: PropTypes.func.isRequired
    commit_disabled: PropTypes.func.isRequired
    add_comment: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
  }

  _on_comment_change: (event) ->
    @props.on_set_comment event.target.value

  _on_select_enable: ->
    @props.on_set_disabled false
  _on_select_disable: ->
    @props.on_set_disabled true

  render: ->
    (cE 'div', {
      className: 'page p_change_status'
      },
      (cE NavTop, {
        title: 'Change status'
        on_back: @props.on_nav_back
        },
        # task_id
        (cE 'span', {
          className: 'task_id'
          },
          "#{@props.task_id}"
        )
      )
      (cE 'div', {
        className: 'page_body'
        },
        # task title
        (cE 'span', {
          className: 'title'
          },
          "#{@props.task_title}"
        )
        @_render_body()
      )
    )

  _render_body: ->
    if ! @props.task_id?
      return null

    (cE 'div', {
      className: 'body'
      },
      @_render_status()
      @_render_disabled()
      @_render_comment()
    )

  _render_status: ->
    if @props.old_disabled
      return null
    button = null
    # only show button if changed
    if @props.status != @props.old_status
      button = (cE MainButton, {
        text: 'Change status'
        on_click: @props.commit_status
        })

    (cE 'div', {
      className: 'status'
      },
      # TODO TODO FIXME improve status list ?
      # status list
      @_render_one_status 'wait', @props.status
      @_render_one_status 'doing', @props.status
      @_render_one_status 'paused', @props.status
      @_render_one_status 'done', @props.status
      @_render_one_status 'fail', @props.status
      @_render_one_status 'cancel', @props.status

      button
    )

  _render_one_status: (status, old_status) ->
    that = this
    _callback = ->
      that.props.on_set_status status

    (cE CheckItem, {
      text: status
      is_selected: (status == old_status)
      on_click: _callback
      })

  _render_disabled: ->
    button = null
    # only show button if changed
    if @props.disabled != @props.old_disabled
      if @props.disabled
        text = 'Disable this task'
      else
        text = 'Enable this task'
      button = (cE MainButton, {
        text
        on_click: @props.commit_disabled
      })

    (cE 'div', {
      className: 'disabled'
      },
      (cE CheckItem, {
        text: 'enable'
        is_selected: (! @props.disabled)
        on_click: @_on_select_enable
        })
      (cE CheckItem, {
        text: 'disable'
        is_selected: @props.disabled
        on_click: @_on_select_disable
        })
      button
    )

  _render_comment: ->
    if @props.old_disabled
      return null
    # only show button if comment is not null
    button = null
    if @props.comment.trim() != ''
      button = (cE MainButton, {
        text: 'Add comment'
        on_click: @props.add_comment
      })

    (cE 'div', {
      className: 'comment'
      },
      (cE FormGroup, null,
        (cE FormControl, {
          componentClass: 'textarea'
          value: @props.comment
          placeholder: 'comment'
          onChange: @_on_comment_change
          })
      )
      # null-fill
      (cE 'div', { className: 'sub_null_fill' })

      button
    )
}

module.exports = Page
