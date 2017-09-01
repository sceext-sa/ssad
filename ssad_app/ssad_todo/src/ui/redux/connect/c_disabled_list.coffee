# c_disabled_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_disabled_list'
action = require '../action/a_disabled_list'
a_enable_task_list = require '../action/a_enable_task_list'


_make_count_and_show_list = ($$main, $$td) ->
  # check no_calc
  no_calc = $$td.get 'no_calc'
  if no_calc
    return {
      count_all: 0
      count_loaded: 0

      task: null
      show_list: []
      di: {}
    }

  disabled_list = $$td.get('disabled_list').toJS()
  count_all = disabled_list.length
  task = $$td.get('task').toJS()
  # TODO improve performance ?

  # make disabled index
  di = {}
  for i in disabled_list
    p = i.split('..')
    di[Number.parseInt(p[1])] = p[0]

  loaded_list = []
  for i in Object.keys(di)
    if task[i]?
      loaded_list.push i
  count_loaded = loaded_list.length
  # sort loaded_list by time  (latest first)
  loaded_list.sort (a, b) ->
    a = di[a]
    b = di[b]

    if a > b
      -1
    else if a < b
      1
    else
      0

  {
    count_all
    count_loaded

    task
    show_list: loaded_list
    di
  }

mapStateToProps = (state, props) ->
  o = _make_count_and_show_list state.main, state.td

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_show_item = (task_id) ->
    dispatch a_enable_task_list.show_item(task_id)
  o.on_load_more= ->
    dispatch action.load_more_tasks()
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
