# doing_operate.coffee, ssad/ssad_app/ssad_todo/src/ui/sub/
# css class: sub_doing_operate

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'


DoingOperate = cC {
  displayName: 'DoingOperate'
  propTypes: {
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'sub_doing_operate'
      },
      (cE 'span', null,
        'Doing, please wait .. . '
      )
    )
}

module.exports = DoingOperate
