# clip_list.coffee, ssad/android_apk/ssad/src/clip/redux/

{ connect } = require 'react-redux'

ClipList = require '../clip_list'
action = require './action/clip_list'


_list_data = ($$state) ->
  index = $$state.get 'index'  # current clip index
  o = $$state.get('data').toJS()
  # add attrs
  for i in [0... o.length]
    o[i].key = i
    o[i].index = index
  # reverse order: most recent at top
  o.reverse()
  for i in [0... o.length]
    o[i].i = (i + 1).toString()
  o

_selected_count = ($$state) ->
  data = $$state.get('data').toJS()
  count = 0  # selected count
  for i in data
    if i.selected
      count += 1
  count

mapStateToProps = (state, props) ->
  $$state = state.clip_list
  {
    edit_mode: $$state.get 'edit_mode'
    refreshing: $$state.get 'refresh'
    list_data: _list_data $$state
    selected_count: _selected_count $$state
  }

mapDispatchToProps = (dispatch, props) ->
  {
    on_enter_edit_mode: ->
      dispatch action.enter_edit_mode()
    on_exit_edit_mode: ->
      dispatch action.exit_edit_mode()
    on_refresh: ->
      dispatch action.refresh()
    on_remove: ->
      dispatch action.remove()
    on_select_item: (index) ->
      dispatch action.select_item(index)
    on_set_clip: (index) ->
      dispatch action.set_clip(index)
  }

O = connect(mapStateToProps, mapDispatchToProps)(ClipList)
module.exports = O
