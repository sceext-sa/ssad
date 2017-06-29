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
    on_nav: PropTypes.func.isRequired
    # TODO
  }

  _on_nav_main: ->
    @props.on_nav 'page_main'
  _on_nav_count: ->
    @props.on_nav 'page_count'

  render: ->
    (cE 'div', {
      className: 'main_top_bar'
      },
      (cE 'span', {
        className: 'save'
        },
        'S'  # TODO
      )
      (cE 'span', {
        className: 'count'
        onClick: @_on_nav_count
        },
        'TODO'  # TODO
      )
      (cE 'span', {
        className: 'title'
        },
        'Unknow title'  # TODO
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
