# r_one_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_one_task'

# $$o: state.main
reducer = ($$o, action) ->
  switch action.type
    when ac.OT_CHANGE_SHOW_DETAIL
      $$o = $$o.set 'show_detail', action.payload
  # TODO
  $$o

module.exports = reducer
