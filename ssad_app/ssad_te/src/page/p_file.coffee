# p_file.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_file

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'


PFile = cC {
  displayName: 'PFile'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_select: ->
    @props.on_nav 'page_file_select'

  render: ->
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
        # TODO
        (cE SubItem, {
          text: 'Select'
          text_sec: 'TODO'
          on_click: @_on_nav_select
          })
        # TODO
      )
    )
}

module.exports = PFile
