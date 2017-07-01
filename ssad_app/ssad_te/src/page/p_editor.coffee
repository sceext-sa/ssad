# p_editor.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'


PEditor = cC {
  displayName: 'PEditor'
  propTypes: {
    cm_scrollbar_style: PropTypes.string.isRequired

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
        # for CodeMirror
        @_render_codemirror()
        # TODO
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
        # TODO core editor config ?
      )
    )

  _render_codemirror: ->
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
}

module.exports = PEditor
