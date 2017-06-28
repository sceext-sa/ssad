# main.coffee, ssad/ssad_app/ssad_te/src/
# css class: main_host

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

Nav = require './redux/nav/n_connect'
CMain = require './redux/connect/c_main'
CFile = require './redux/connect/c_file'
CFileSelect = require './redux/connect/c_file_select'
CEditor = require './redux/connect/c_editor'
CEditorMode = require './redux/connect/c_editor_mode'
CEditorTheme = require './redux/connect/c_editor_theme'
CEditorFontSize = require './redux/connect/c_editor_font_size'
CEditorAdvanced = require './redux/connect/c_editor_advanced'
CConfig = require './redux/connect/c_config'
CConfigIdKey = require './redux/connect/c_config_id_key'
CConfigCore = require './redux/connect/c_config_core'
CAbout = require './redux/connect/c_about'
CCount = require './redux/connect/c_count'


Main = cC {
  displayName: 'Main'
  propTypes: {
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'main_host'
      },
      (cE Nav, null,
        # all pages
        (cE CMain, { id: 'page_main' })
          (cE CFile, { id: 'page_file' })
            (cE CFileSelect, { id: 'page_file_select' })
          (cE CEditor, { id: 'page_editor' })
            (cE CEditorMode, { id: 'page_editor_mode' })
            (cE CEditorTheme, { id: 'page_editor_theme' })
            (cE CEditorFontSize, { id: 'page_editor_font_size' })
            (cE CEditorAdvanced, { id: 'page_editor_advanced' })
          # TODO page_edit ?
          (cE CConfig, { id: 'page_config' })
            (cE CConfigIdKey, { id: 'page_config_id_key' })
            (cE CConfigCore, { id: 'page_config_core' })
          (cE CAbout, { id: 'page_about' })
        (cE CCount, { id: 'page_count' })
      )
    )
}

module.exports = Main
