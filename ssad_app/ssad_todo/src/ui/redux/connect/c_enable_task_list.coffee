# c_enable_task_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/connect/

{ connect } = require 'react-redux'

Page = require '../../page/p_enable_task_list'
action = require '../action/a_enable_task_list'


_make_count_and_show_list = ($$main, $$td) ->
  task = $$td.get('task').toJS()
  task_list = $$td.get('task_list').toJS()
  # TODO FIXME TODO better sort task
  task_list.sort()
  task_list.reverse()

  set = {  # set of each task status
    init: []
    wait: []
    doing: []
    paused: []
    done: []
    fail: []
    cancel: []
  }
  for i in task_list
    if task[i]?
      st = task[i].status
      set[st].push i
  count_current = set.doing.length + set.wait.length + set.paused.length + set.init.length
  count_err = set.fail.length + set.cancel.length
  count_ok = set.done.length

  show_list_name = $$main.get 'show_list'
  switch show_list_name
    when 'current'
      show_list = [
        ['doing', set.doing]
        ['wait', set.wait]
        ['paused', set.paused]
        ['init', set.init]
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
    count_current
    count_err
    count_ok
    show_list
    show_list_name
  }
  # TODO better sort tasks ?

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
