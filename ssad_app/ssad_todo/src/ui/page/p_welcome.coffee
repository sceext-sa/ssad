# p_welcome.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_welcome

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


Page = cC {
  displayName: 'PWelcome'
  propTypes: {
    app_id: PropTypes.string.isRequired
    ssad_key: PropTypes.string.isRequired
    #error: TODO

    on_change_id: PropTypes.func.isRequired
    on_change_key: PropTypes.func.isRequired
    on_ok: PropTypes.func.isRequired
  }

  _on_change_id: (event) ->
    @props.on_change_id event.target.value

  _on_change_key: (event) ->
    @props.on_change_key event.target.value

  render: ->
    (cE 'div', {
      className: 'page p_welcome'
      },
      (cE NavTop, {
        title: 'Welcome to SSAD todo'
        title_center: true
        })
      (cE 'div', {
        className: 'page_body'
        },
        (cE 'div', {
          className: 'pad'
          },
          # input app_id / key
          @_render_form()
          # error info
          @_render_error()
        )
        # null-fill
        (cE 'div', { className: 'sub_null_fill' })
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
    )

  _render_error: ->
    if @props.error?
      (cE Alert, {
        bsStyle: 'danger'
        },
        (cE 'strong', null,
          'Error '
        )
        @props.error
      )
}

module.exports = Page
