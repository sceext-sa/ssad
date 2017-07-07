# p_editor.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

core_editor = require '../core_editor'
NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'
CheckItem = require '../sub/check_item'


PEditor = cC {
  displayName: 'PEditor'
  propTypes: {
    show_line_number: PropTypes.bool.isRequired
    line_wrap: PropTypes.bool.isRequired
    read_only: PropTypes.bool.isRequired
    tab_size: PropTypes.number.isRequired  # TODO
    overwrite: PropTypes.bool.isRequired
    show_invisibles: PropTypes.bool.isRequired
    core_editor: PropTypes.string.isRequired

    cm_scrollbar_style: PropTypes.string.isRequired
    ace_scroll_past_end: PropTypes.bool.isRequired

    on_set_show_line_number: PropTypes.func.isRequired
    on_set_line_wrap: PropTypes.func.isRequired
    on_set_read_only: PropTypes.func.isRequired
    on_set_tab_size: PropTypes.func.isRequired
    on_set_overwrite: PropTypes.func.isRequired
    on_set_show_invisibles: PropTypes.func.isRequired

    on_set_ace_scroll_past_end: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_mode: ->
    @props.on_nav 'page_editor_mode'
  _on_nav_theme: ->
    @props.on_nav 'page_editor_theme'
  _on_nav_font_size: ->
    @props.on_nav 'page_editor_font_size'
  _on_nav_advanced: ->
    @props.on_nav 'page_editor_advanced'
  _on_nav_cm_scrollbar_style: ->
    @props.on_nav 'page_editor_cm_scrollbar_style'

  _on_set_show_line_number: ->
    @props.on_set_show_line_number (! @props.show_line_number)
  _on_set_line_wrap: ->
    @props.on_set_line_wrap (! @props.line_wrap)
  _on_set_read_only: ->
    @props.on_set_read_only (! @props.read_only)
  # TODO set tab_size
  _on_set_overwrite: ->
    @props.on_set_overwrite (! @props.overwrite)
  _on_set_show_invisibles: ->
    @props.on_set_show_invisibles (! @props.show_invisibles)

  _on_set_ace_scroll_past_end: ->
    @props.on_set_ace_scroll_past_end (! @props.ace_scroll_past_end)

  render: ->
    (cE 'div', {
      className: 'page p_editor'
      },
      (cE NavTop, {
        title: 'Editor'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # TODO common config ?
        # sub_item: mode
        (cE SubItem, {
          text: 'Mode'
          text_sec: 'TODO'
          on_click: @_on_nav_mode
          })
        # sub_item: theme
        (cE SubItem, {
          text: 'Theme'
          text_sec: 'TODO'
          on_click: @_on_nav_theme
          })
        # sub_item: font_size
        (cE SubItem, {
          text: 'Font size'
          text_sec: 'TODO'
          on_click: @_on_nav_font_size
          })
        # flag_config: show_line_number
        (cE CheckItem, {
          text: 'Show line number'
          is_selected: @props.show_line_number
          show_off: true
          on_click: @_on_set_show_line_number
          })
        # flag_config: line_wrap
        (cE CheckItem, {
          text: 'Line wrap'
          is_selected: @props.line_wrap
          show_off: true
          on_click: @_on_set_line_wrap
          })
        # flag_config: read_only
        (cE CheckItem, {
          text: 'Read only'
          is_selected: @props.read_only
          show_off: true
          on_click: @_on_set_read_only
          })
        # flag_config: overwrite
        (cE CheckItem, {
          text: 'Overwrite'
          is_selected: @props.overwrite
          show_off: true
          on_click: @_on_set_overwrite
          })
        # flag_config: show_invisibles
        (cE CheckItem, {
          text: 'Show invisibles'
          is_selected: @props.show_invisibles
          show_off: true
          on_click: @_on_set_show_invisibles
          })

        # for CodeMirror
        @_render_codemirror()
        # for ACE
        @_render_ace()
        # TODO null fill
        (cE 'div', {
          style: {
            flex: 1
          } })
        # sub_item: advanced
        (cE SubItem, {
          text: 'Advanced'
          on_click: @_on_nav_advanced
          })
      )
    )

  _render_codemirror: ->
    if @props.core_editor != core_editor.CORE_EDITOR_CODEMIRROR
      return
    (cE 'div', {
      className: 'codemirror'
      },
      (cE 'span', {
        className: 'title'
        },
        'CodeMirror'
      )
      # sub_item: cm_scrollbar_style
      (cE SubItem, {
        text: 'Scrollbar Style'
        text_sec: @props.cm_scrollbar_style
        on_click: @_on_nav_cm_scrollbar_style
        })
    )

  _render_ace: ->
    if @props.core_editor != core_editor.CORE_EDITOR_ACE
      return
    (cE 'div', {
      className: 'ace'
      },
      (cE 'span', {
        className: 'title'
        },
        'ACE'
      )
      # flag_config: show_invisibles
      (cE CheckItem, {
        text: 'Scroll past end'
        is_selected: @props.ace_scroll_past_end
        show_off: true
        on_click: @_on_set_ace_scroll_past_end
        })
    )
}

module.exports = PEditor
