# main_top_bar.coffee, ssad/ssad_app/ssad_te/src/
# css class: main_top_bar

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'


MainTopBar = cC {
  displayName: 'MainTopBar'
  propTypes: {
    filename: PropTypes.string
    is_clean: PropTypes.bool.isRequired

    on_save: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_main: ->
    @props.on_nav 'page_main'
  _on_nav_count: ->
    @props.on_nav 'page_count'

  _render_save: ->
    if @props.is_clean
      (cE 'span', {
        className: 'save'
        },
        (cE Glyphicon, {
          glyph: 'ok'
          })
      )
    else
      (cE 'span', {
        className: 'save active'
        onClick: @props.on_save
        },
        'S'
      )

  render: ->
    f_name = 'No file'
    if @props.filename?
      f_name = @props.filename

    (cE 'div', {
      className: 'main_top_bar'
      },
      @_render_save()
      (cE 'span', {
        className: 'count'
        onClick: @_on_nav_count
        },
        'TODO'  # TODO
      )
      (cE 'span', {
        className: 'title'
        },
        f_name
      )
      (cE 'span', {
        className: 'undo'
        },
        'U'  # TODO
      )
      (cE 'span', {
        className: 'to_main'
        onClick: @_on_nav_main
        },
        (cE Glyphicon, {
          glyph: 'option-vertical'
          })
      )
    )
}

module.exports = MainTopBar
