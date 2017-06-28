# p_main.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_main

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'


PMain = cC {
  displayName: 'PMain'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_file: ->
    @props.on_nav 'page_file'
  _on_nav_editor: ->
    @props.on_nav 'page_editor'
  _on_nav_config: ->
    @props.on_nav 'page_config'
  _on_nav_about: ->
    @props.on_nav 'page_about'

  render: ->
    (cE 'div', {
      className: 'page p_main'
      },
      (cE NavTop, {
        title: 'Text Editor on SSAD'
        title_center: true
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # sub_item: page_file
        (cE SubItem, {
          text: 'File'
          on_click: @_on_nav_file
          })
        # sub_item: page_editor
        (cE SubItem, {
          text: 'Editor'
          on_click: @_on_nav_editor
          })
        # TODO page_edit?
        # FIXME null fill
        (cE 'div', {
          style: {
            flex: 1
          } })
        # sub_item: page_config
        (cE SubItem, {
          text: 'Config'
          on_click: @_on_nav_config
          })
        # sub_item: page_about
        (cE SubItem, {
          text: 'About'
          on_click: @_on_nav_about
          })
      )
    )
}

module.exports = PMain
