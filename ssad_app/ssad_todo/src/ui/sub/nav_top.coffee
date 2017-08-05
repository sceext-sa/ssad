# nav_top.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: nav_top

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


NavTop = cC {
  displayName: 'NavTop'
  propTypes: {
    title: PropTypes.string.isRequired
    title_center: PropTypes.bool

    on_back: PropTypes.func
    # children
  }

  _render_back: ->
    if @props.on_back?
      (cE 'span', {
        className: 'back'
        onClick: @props.on_back
        },
        '<'
      )

  render: ->
    title_class = 'title'
    if @props.title_center
      title_class += ' center'

    (cE 'div', {
      className: 'nav_top'
      },
      @_render_back()
      (cE 'span', {
        className: title_class
        },
        @props.title
      )
      # right button
      @props.children
    )
}

module.exports = NavTop
