# nav.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: nav_host, nav_sub

React = require 'react'
{ createElement: cE } = React
cC = require 'create-react-class'
PropTypes = require 'prop-types'


NavSub = cC {
  displayName: 'NavSub'
  propTypes: {
    pos: PropTypes.string.isRequired
    # children
  }

  render: ->
    (cE 'div', {
      className: 'nav_sub ' + @props.pos
      },
      @props.children
    )
}

# nav host
Nav = cC {
  displayName: 'Nav'
  propTypes: {
    pos: PropTypes.object.isRequired

    on_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
    # children
  }

  render: ->
    on_nav_back = @props.on_back
    on_nav = @props.on_nav
    p = @props.pos

    children = React.Children.map @props.children, (child) ->
      c = React.cloneElement child, {
        on_nav_back
        on_nav
      }
      (cE NavSub, {
        pos: p[child.props.id]
        key: child.props.id
        },
        c
      )

    (cE 'div', {
      className: 'nav_host'
      },
      children
    )
}

module.exports = Nav
