# c_count.coffee, ssad/ssad_app/ssad_te/src/redux/connect/

{ connect } = require 'react-redux'

PCount = require '../../page/p_count'
action = require '../action/a_count'


mapStateToProps = (state, props) ->
  $$state = state.main
  {
    info: $$state.getIn(['count', 'info']).toJS()
    main: $$state.getIn ['count', 'main']
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_set_main = (main) ->
    dispatch action.set_main(main)
  o.on_refresh = ->
    dispatch action.refresh()
  o

O = connect(mapStateToProps, mapDispatchToProps)(PCount)
module.exports = O
