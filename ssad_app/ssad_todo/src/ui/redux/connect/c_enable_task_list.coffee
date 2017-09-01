# c_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_enable_task_list'
action = require '../action/a_enable_task_list'


_make_count_and_show_list = ($$main, $$td) ->
  # no render when no_calc is enabled
  no_calc = $$td.get 'no_calc'
  if no_calc
    return {
      task: null
      count_before: 0
      count_current: 0
      count_err: 0
      count_ok: 0
      show_list: []
      show_list_name: 'current'
    }

  task = $$td.get('task').toJS()
  task_list = []
  for i in $$td.get('task_list').toJS()
    task_list.push Number.parseInt(i)
  # first sort by task_id
  task_list.sort (a, b) ->
    b - a
  # second task sort by last_time
  last_time_index = {}
  for i in task_list
    if ! task[i]?
      continue
    last_time = task[i].calc.last_time
    if last_time_index[last_time]?
      last_time_index[last_time].push i
    else
      last_time_index[last_time] = [i]
  last_time = Object.keys last_time_index
  last_time.sort()
  last_time.reverse()  # latest first
  task_list = []
  for i in last_time
    for j in last_time_index[i]
      task_list.push j

  set = {  # set of each task status
    init: []
    wait: []
    doing: []
    paused: []
    done: []
    fail: []
    cancel: []
    disabled: []  # only for FIX bug
    ready: []  # for auto_ready
  }
  for i in task_list
    if task[i]?
      st = task[i].calc.status
      if st?
        set[st].push i
  count_before = set.wait.length + set.ready.length + set.init.length
  count_current = set.doing.length + set.paused.length
  count_err = set.fail.length + set.cancel.length
  count_ok = set.done.length

  show_list_name = $$main.get 'show_list'
  switch show_list_name
    when 'before'
      show_list = [
        ['wait', set.wait]
        ['ready', set.ready]
        ['init', set.init]
      ]
    when 'current'
      show_list = [
        ['doing', set.doing]
        ['paused', set.paused]
      ]
    when 'err'
      show_list = [
        ['fail', set.fail]
        ['cancel', set.cancel]
      ]
    when 'ok'
      show_list = [
        ['done', set.done]
      ]
  {
    task
    count_before
    count_current
    count_err
    count_ok
    show_list
    show_list_name
  }

mapStateToProps = (state, props) ->
  o = _make_count_and_show_list state.main, state.td

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props  # pass all props
  o.on_change_list = (name) ->
    dispatch action.change_list(name)
  o.on_show_item = (task_id) ->
    dispatch action.show_item(task_id)
  o

O = connect(mapStateToProps, mapDispatchToProps)(Page)
module.exports = O
