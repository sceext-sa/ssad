# r_count.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_count'


# $$o = state.main.count
reducer = ($$o, action) ->
  switch action.type
    when ac.COUNT_REFRESH
      $$o = $$o.set 'info', Immutable.fromJS(action.payload)
    when ac.COUNT_SET_MAIN
      $$o = $$o.set 'main', action.payload
  $$o

module.exports = reducer
