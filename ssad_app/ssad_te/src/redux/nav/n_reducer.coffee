# n_reducer.coffee, ssad/ssad_app/ssad_te/src/redux/nav/

Immutable = require 'immutable'

state = require '../state'
ac = require './n_action'
tree = require './tree'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.nav
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.NAV_BACK
      if $$o.get('path').size > 0
        # update path, current
        $$o = $$o.set 'current', $$o.get('path').last()
        $$o = $$o.update 'path', ($$path) ->
          $$path.pop()
      # else: can not back
    when ac.NAV_GO
      id = action.payload
      if tree.PAGE_LIST.indexOf(id) != -1
        # update path, current
        $$o = $$o.update 'path', ($$path) ->
          $$path.push $$o.get('current')
        $$o = $$o.set 'current', id
      # else: no such page
  $$o

module.exports = reducer
