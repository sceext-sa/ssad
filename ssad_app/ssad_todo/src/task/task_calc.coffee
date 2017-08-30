# task_calc.coffee, ssad/ssad_app/ssad_todo/src/task/

task_status = require '../td/task_status'
auto_ready = require './auto_ready'


_make_history_index = (task) ->
  history_name = Object.keys task.history
  history_name.sort()
  history_name.reverse()  # latest history first
  history_name

# get current status of one task from history items
_get_current_status = (task) ->
  for i in _make_history_index(task)
    h = task.history[i]
    if h.data.status?
      return h.data.status
  # no history item has `status`
  task_status.INIT

# get latest task comment, or task desc
_get_latest_text = (task) ->
  for i in _make_history_index(task)
    h = task.history[i]
    if h.data.note?
      return h.data.note
  # no 'note' history, use task desc
  desc = task.raw.data.desc
  if ! desc?
    desc = ''  # use empty str
  desc

# task last update time, for sort task
_get_last_time = (task) ->
  # get all history time
  ht = Object.keys task.history_list
  # add one: task raw last_update time
  ht.push task.raw._time
  # sort time
  ht.sort()
  ht.reverse()  # use latest one
  ht[0]


_is_task_disabled = (task_id, enable_list) ->
  enable_list.indexOf(task_id) is -1

# calc attr
calc_one_task = (task_id, task, enable_list) ->
  o = {
    disabled: _is_task_disabled task_id, enable_list
    status: _get_current_status task
    text: _get_latest_text task
    last_time: _get_last_time task

    first_status: null
    second_status: 'out'  # out by default
    last_end: ''

    planned_start: null
    ddl: null
    is_ready: false
  }
  # status and first_status
  if o.disabled
    o.status = 'disabled'
  else
    o.first_status = o.status

  # TODO
  o


module.exports = {
  calc_one_task
}
