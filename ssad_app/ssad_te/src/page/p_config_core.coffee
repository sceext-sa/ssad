# p_config_core.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_config_core, core_item

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'

core_editor = require '../core_editor'
NavTop = require '../sub/nav_top'


CoreItem = cC {
  displayName: 'CoreItem'
  propTypes: {
    id: PropTypes.string.isRequired
    name: PropTypes.string.isRequired
    version: PropTypes.string.isRequired
    desc: PropTypes.string  # TODO
    url: PropTypes.string.isRequired
    selected: PropTypes.bool

    on_click: PropTypes.func.isRequired
  }

  render: ->
    c = 'core_item'
    if @props.selected
      c += ' selected'
    (cE 'div', {
      className: c
      onClick: @props.on_click
      },
      (cE 'h2', null,
        (cE 'span', {
          className: 'left'
          },
          @_render_left()
        )
        @props.id
        (cE 'span', {
          className: 'version'
          },
          @props.version
        )
      )
      (cE 'p', null,
        @props.name
      )
      (cE 'a', {
        href: @props.url
        },
        @props.url
      )
    )

  _render_left: ->
    if @props.selected
      (cE Glyphicon, {
        glyph: 'ok'
        })
}

PConfigCore = cC {
  displayName: 'PConfigCore'
  propTypes: {
    doc_clean: PropTypes.bool.isRequired
    core_editor: PropTypes.string.isRequired

    on_set_core: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  _on_core_cm: ->
    @props.on_set_core core_editor.CORE_EDITOR_CODEMIRROR
  _on_core_ace: ->
    @props.on_set_core core_editor.CORE_EDITOR_ACE

  render: ->
    (cE 'div', {
      className: 'page p_config_core'
      },
      (cE NavTop, {
        title: 'Core editor'
        on_back: @props.on_nav_back
        })
      if @props.doc_clean
        @_render_core_list()
      else
        @_render_save_file()
    )

  _render_save_file: ->
    (cE 'div', {
      className: 'page_body center'
      },
      (cE 'span', {
        className: 'save_file'
        },
        'Please save file before'
        (cE 'br')
        ' switch core'
      )
    )

  _render_core_list: ->
    (cE 'div', {
      className: 'page_body'
      },
      (cE CoreItem, {
        id: core_editor.CORE_EDITOR_CODEMIRROR
        name: 'CodeMirror: Full-featured in-browser code editor'
        version: core_editor.get_core_version(core_editor.CORE_EDITOR_CODEMIRROR)
        url: 'http://codemirror.net'

        selected: (@props.core_editor == core_editor.CORE_EDITOR_CODEMIRROR)
        on_click: @_on_core_cm
        })
      (cE CoreItem, {
        id: core_editor.CORE_EDITOR_ACE
        name: 'Ace (Ajax.org Cloud9 Editor)'
        version: core_editor.get_core_version(core_editor.CORE_EDITOR_ACE)
        url: 'https://github.com/ajaxorg/ace-builds'

        selected: (@props.core_editor == core_editor.CORE_EDITOR_ACE)
        on_click: @_on_core_ace
        })
    )
}

module.exports = PConfigCore
