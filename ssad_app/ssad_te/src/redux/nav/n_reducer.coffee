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
      if $$o.get('stack').size > 0
        # update stack, current
        $$o = $$o.set 'current', $$o.get('stack').last()
        $$o = $$o.update 'stack', ($$stack) ->
          $$stack.pop()
      # else: can not back
    when ac.NAV_GO
      id = action.payload
      if (tree.PAGE_LIST.indexOf(id) != -1) && (id != $$o.get('current'))  # is not current
        # update stack, current
        $$o = $$o.update 'stack', ($$stack) ->
          $$stack.push $$o.get('current')
        $$o = $$o.set 'current', id
      # else: no such page
  $$o

module.exports = reducer
