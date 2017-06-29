# p_file_select.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_file_select

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
FileList = require '../sub/file_list'


PFileSelect = cC {
  displayName: 'PFileSelect'
  propTypes: {
    need_config_key: PropTypes.bool.isRequired

    app_id: PropTypes.string
    ssad_key: PropTypes.string

    on_load_dir: PropTypes.func.isRequired
    on_select_file: PropTypes.func.isRequired
    on_error: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_file_select'
      },
      (cE NavTop, {
        title: 'Select'
        on_back: @props.on_nav_back
        })
      if @props.need_config_key
        (cE 'div', {
          className: 'page_body'
          },
          (cE 'div', {
            className: 'need_config_key'
            },
            (cE 'span', null,
              'Please set APP_ID and SSAD_KEY '
              (cE 'br')
              'in Config page first'
            )
          )
        )
      else
        @_render_body()
    )

  _render_body: ->
    (cE FileList, {
      app_id: @props.app_id
      ssad_key: @props.ssad_key

      on_error: @props.on_error
      on_load_dir: @props.on_load_dir
      on_select_file: @props.on_select_file
      })
}

module.exports = PFileSelect
