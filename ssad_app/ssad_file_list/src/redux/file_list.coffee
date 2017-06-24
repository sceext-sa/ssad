# file_list.coffee, ssad/ssad_app/ssad_file_list/src/redux/

{ connect } = require 'react-redux'

FileList = require '../file_list'
action = require './action'


_make_list_data = ($$state) ->
  if ! $$state.get('data')?
    return []  # empty data
  dir = $$state.get('data').toJS().dir

  o = []
  # add . ..
  o.push {
    name: '.'
    type: 'dir'
  }
  # if no sub_root, no '..' option
  if $$state.get('sub_root')?
    o.push {
      name: '..'
      type: 'dir'
    }
  # add each item
  keys = Object.keys dir
  keys.sort()

  for i in keys
    one = {
      name: i
      type: dir[i].type
    }
    if dir[i].size?
      one.size = dir[i].size
    o.push one
  o

_make_error_info = ($$state) ->
  error = $$state.get 'error'
  if error?
    # TODO improve output
    error.toString()

_should_show_input_key = ($$state) ->
  if $$state.get('error')?
    true
  else if ! $$state.get('app_id')?
    true
  else
    false

mapStateToProps = ($$state, props) ->
  {
    list: _make_list_data $$state

    input: $$state.get('input').toJS()
    error: _make_error_info $$state
    show_input_key: _should_show_input_key $$state
  }

mapDispatchToProps = (dispatch, props) ->
  {
    on_load_dir: (name) ->
      dispatch action.load(name)
    on_select_file: (name) ->
      dispatch action.select_file(name)
    on_change_id: (text) ->
      dispatch action.change_id(text)
    on_change_key: (text) ->
      dispatch action.change_key(text)
    on_save_config: ->
      dispatch action.save_config()
  }

O = connect(mapStateToProps, mapDispatchToProps)(FileList)
module.exports = O
