# p_config.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_config

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  FormGroup
  ControlLabel
  FormControl
} = require 'react-bootstrap'

NavTop = require '../sub/nav_top'
MainButton = require '../sub/main_button'


Page = cC {
  displayName: 'PConfig'
  propTypes: {
    init_load_time_s: PropTypes.number.isRequired
    init_load_thread_n: PropTypes.string.isRequired

    on_set_init_load_thread_n: PropTypes.func.isRequired
    on_save_init_load_thread_n: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
  }

  _on_change_init_load_thread_n: (event) ->
    @props.on_set_init_load_thread_n event.target.value

  render: ->
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
        # show init_load time
        (cE 'div', {
          className: 'init_load_time'
          },
          'init_load_time '
          (cE 'span', {
            className: 'value'
            },
            "#{@props.init_load_time_s}"
          )
          's'
        )
        # set init_load thread
        (cE 'div', {
          className: 'config_thread'
          },
          (cE FormGroup, null,
            (cE ControlLabel, null,
              'init_load thread'
            )
            (cE FormControl, {
              type: 'text'
              value: @props.init_load_thread_n
              placeholder: 'thread_n'
              onChange: @_on_change_init_load_thread_n
            })
          )
          # main button
          (cE MainButton, {
            text: 'Save thread'
            on_click: @props.on_save_init_load_thread_n
          })
        )
      )
    )
}

module.exports = Page
