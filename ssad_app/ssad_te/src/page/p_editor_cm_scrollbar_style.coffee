# p_editor_cm_scrollbar_style.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_editor_cm_scrollbar_style

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
CheckItem = require '../sub/check_item'


PEditorCmScrollbarStyle = cC {
  displayName: 'PEditorCmScrollbarStyle'
  propTypes: {
    cm_scrollbar_style: PropTypes.string.isRequired

    on_set_style: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  _on_set_native: ->
    @props.on_set_style 'native'
  _on_set_overlay: ->
    @props.on_set_style 'overlay'
  _on_set_null: ->
    @props.on_set_style 'null'
  _on_set_simple: ->
    @props.on_set_style 'simple'

  render: ->
    (cE 'div', {
      className: 'page p_editor_cm_scrollbar_style'
      },
      (cE NavTop, {
        title: 'Scrollbar Style'
        on_back: @props.on_nav_back
        })
      (cE 'div', {
        className: 'page_body'
        },
        # TODO background-opacity pre-view ?
        (cE CheckItem, {
          text: 'native'
          is_selected: ('native' == @props.cm_scrollbar_style)

          on_click: @_on_set_native
          })
        (cE CheckItem, {
          text: 'overlay'
          is_selected: ('overlay' == @props.cm_scrollbar_style)

          on_click: @_on_set_overlay
          })
        (cE CheckItem, {
          text: 'null'
          is_selected: ('null' == @props.cm_scrollbar_style)

          on_click: @_on_set_null
          })
        (cE CheckItem, {
          text: 'simple'
          is_selected: ('simple' == @props.cm_scrollbar_style)

          on_click: @_on_set_simple
          })
      )
    )
}

module.exports = PEditorCmScrollbarStyle
