# p_config_id_key.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_config_id_key

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'


PConfigIdKey = cC {
  displayName: 'PConfigIdKey'
  propTypes: {
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_config_id_key'
      },
      (cE NavTop, {
        title: 'APP_ID / SSAD_KEY'
        on_back: @props.on_nav_back
        })
      # TODO
    )
}

module.exports = PConfigIdKey
