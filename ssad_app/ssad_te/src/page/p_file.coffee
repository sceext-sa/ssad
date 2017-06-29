# p_file.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_file

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'
MainButton = require '../sub/main_button'


PFile = cC {
  displayName: 'PFile'
  propTypes: {
    filename: PropTypes.string
    is_clean: PropTypes.bool.isRequired

    on_open: PropTypes.func.isRequired
    on_save: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_select: ->
    @props.on_nav 'page_file_select'

  render: ->
    f_name = 'No file'
    if @props.filename?
      f_name = @props.filename

    (cE 'div', {
      className: 'page p_file'
      },
      (cE NavTop, {
        title: 'File'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        (cE SubItem, {
          text: 'Select'
          text_sec: f_name
          on_click: @_on_nav_select
          })
        # TODO auto save ? (logs ?)
        # TODO null fill
        (cE 'div', {
          style: {
            flex: 1
          } })
        # main button
        @_render_main_button()
      )
    )

  _render_main_button: ->
    if @props.filename?
      if @props.is_clean
        (cE MainButton, {
          text: 'Open'
          on_click: @props.on_open
          })
      else
        (cE MainButton, {
          text: 'Save'
          on_click: @props.on_save
          })
}

module.exports = PFile
