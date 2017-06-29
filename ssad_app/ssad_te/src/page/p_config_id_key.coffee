# p_config_id_key.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_config_id_key

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  FormGroup
  ControlLabel
  FormControl
  Alert
} = require 'react-bootstrap'

NavTop = require '../sub/nav_top'
MainButton = require '../sub/main_button'


PConfigIdKey = cC {
  displayName: 'PConfigIdKey'
  propTypes: {
    app_id: PropTypes.string.isRequired
    ssad_key: PropTypes.string.isRequired
    error_info: PropTypes.string

    on_change_id: PropTypes.func.isRequired
    on_change_key: PropTypes.func.isRequired
    on_ok: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  _on_change_id: (event) ->
    @props.on_change_id event.target.value
  _on_change_key: (event) ->
    @props.on_change_key event.target.value

  render: ->
    (cE 'div', {
      className: 'page p_config_id_key'
      },
      (cE NavTop, {
        title: 'APP_ID / SSAD_KEY'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        @_render_form()
        # null fill
        (cE 'div', {
          style: {
            flex: 1
          } })
        # main button
        (cE MainButton, {
          text: 'OK'
          on_click: @props.on_ok
          })
      )
    )

  _render_form: ->
    (cE 'form', null,
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'APP_ID'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.app_id
          placeholder: 'input APP_ID here'
          onChange: @_on_change_id
          })
      )
      (cE FormGroup, null,
        (cE ControlLabel, null,
          'SSAD_KEY'
        )
        (cE FormControl, {
          type: 'text'
          value: @props.ssad_key
          placeholder: 'input SSAD_KEY here'
          onChange: @_on_change_key
          })
      )
      @_render_error()
    )

  _render_error: ->
    if @props.error_info?
      (cE Alert, {
        bsStyle: 'danger'
        },
        (cE 'strong', null,
          'Error'
        )
        @props.error_info
      )
}

module.exports = PConfigIdKey
