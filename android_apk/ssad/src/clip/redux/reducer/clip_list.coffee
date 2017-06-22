# clip_list.coffee, ssad/android_apk/ssad/src/clip/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/clip_list'


_cancel_all_select = ($$state) ->
  # TODO improve performance with Immutable map ?
  data = $$state.get('data').toJS()
  for i in data
    i.selected = false
  $$o = $$state.set 'data', Immutable.fromJS(data)
  $$o

_clip_changed = ($$state, data) ->
  list = []
  for i in data.list
    list.push {
      text: i.text
      time: i.time
    }
  $$o = $$state.set 'data', Immutable.fromJS(list)
  $$o = $$o.set 'index', data.index
  $$o

_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.clip_list
  $$o

reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.CLIP_ENTER_EDIT_MODE
      $$o = $$o.set 'edit_mode', true
      $$o = _cancel_all_select $$o
    when ac.CLIP_EXIT_EDIT_MODE
      $$o = $$o.set 'edit_mode', false
      $$o = _cancel_all_select $$o
    when ac.CLIP_SELECT_ITEM
      $$o.updateIn ['data', action.payload, 'selected'], (selected) ->
        ! selected
    #when ac.CLIP_REMOVE
    #when ac.CLIP_SET_CLIP
    #when ac.CLIP_INIT
    when ac.CLIP_CHANGED
      $$o = _clip_changed $$o, action.payload
      $$o = $$o.set 'refresh', false
    when ac.CLIP_REFRESH
      $$o = $$o.set 'refresh', true
  $$o

module.exports = reducer
