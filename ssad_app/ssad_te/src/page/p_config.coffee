# p_config.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_config

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'


PConfig = cC {
  displayName: 'PConfig'
  propTypes: {
    core_editor: PropTypes.string
    need_config_key: PropTypes.bool.isRequired
    key_error: PropTypes.bool

    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_id_key: ->
    @props.on_nav 'page_config_id_key'
  _on_nav_core: ->
    @props.on_nav 'page_config_core'

  render: ->
    core = ''
    switch @props.core_editor
      when 'codemirror'
        core = 'CodeMirror'
      when 'ace'
        core = 'ACE'
    k = 'OK'
    if @props.need_config_key
      k = 'TODO'
    if @props.key_error
      k = 'Error'

    (cE 'div', {
      className: 'page p_config'
      },
      (cE NavTop, {
        title: 'Config'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # sub_item: id_key
        (cE SubItem, {
          text: 'APP_ID / SSAD_KEY'
          text_sec: k
          on_click: @_on_nav_id_key
          })
        # sub_item: core
        (cE SubItem, {
          text: 'Core editor'
          text_sec: core
          on_click: @_on_nav_core
          })
        # TODO
      )
    )
}

module.exports = PConfig
