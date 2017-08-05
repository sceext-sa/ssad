# p_file_auto_save.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_file_auto_save

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
CheckItem = require '../sub/check_item'


PFileAutoSave = cC {
  displayName: 'PFileAutoSave'
  propTypes: {
    enable: PropTypes.bool.isRequired
    log_text: PropTypes.string

    on_set_enable: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  _on_set_enable: ->
    @props.on_set_enable (! @props.enable)

  render: ->
    (cE 'div', {
      className: 'page p_file_auto_save'
      },
      (cE NavTop, {
        title: 'Auto save'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # log text
        (cE 'div', {
          className: 'log_text'
          },
          @props.log_text
        )
        # enable/disable auto_save button
        (cE CheckItem, {
          text: 'Enable auto save'
          is_selected: @props.enable
          show_off: true
          on_click: @_on_set_enable
          })
      )
    )
}

module.exports = PFileAutoSave
