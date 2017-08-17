# init_load_task.coffee, ssad/ssad_app/ssad_todo/src/task/

config = require '../config'
a_common = require '../ui/redux/action/a_common'
a_task_info = require '../ui/redux/action/a_task_info'
td = require '../td/td'

task_op = require './task_op'


_dispatch = (action) ->
  config.store().dispatch action

# TODO more error process ?
init_load_task = ->
  # get task lists
  raw_enable_list = await td.get_task_list()
  raw_disabled_list = await td.get_disabled_list()
  # to-load count
  count_to_load_disabled = raw_disabled_list.length
  if count_to_load_disabled > config.DEFAULT_LOAD_DISABLED_N
    count_to_load_disabled = config.DEFAULT_LOAD_DISABLED_N
  count_to_load = raw_enable_list.length + count_to_load_disabled
  _dispatch a_common.update_init_progress({
    all: count_to_load
    done: false
    now: 0
  })

  count_load = 0  # loaded tasks
  enable_list = {}
  # load all enabled tasks (with default number of history items)
  for task_id in raw_enable_list
    raw = await td.load_task_and_history task_id
    one = task_op.make_load_task_and_history raw
    tasks = {}
    tasks[task_id] = one
    _dispatch a_task_info.load_tasks(tasks)
    # update enable_list
    last_time = task_op.get_task_last_update_time one
    enable_list[last_time] = task_id

    count_load += 1
    _dispatch a_common.update_init_progress({
      now: count_load
    })

  # create disabled task index
  time_to_disabled = {}
  for i in raw_disabled_list
    p = i.split('..')  # ISO_TIME..TASK_ID
    time = p[0]
    task_id = Number.parseInt p[1]

    if ! time_to_disabled[time]?
      time_to_disabled[time] = [task_id]
    else
      time_to_disabled[time].push task_id
  time_list = Object.keys time_to_disabled
  # load some latest disabled tasks
  time_list.sort()
  time_list.reverse()  # load latest items

  disabled_list = {}
  for i in [0... config.DEFAULT_LOAD_DISABLED_N]
    if i >= time_list.length
      break
    time = time_list[i]
    to_load = time_to_disabled[time]
    for task_id in to_load
      # load one task
      task_name = td.make_disabled_task_name task_id, time
      raw = await td.load_task task_name
      # make task info
      task = {
        raw
        history: {}
      }
      tasks = {}
      tasks[task_id] = task
      _dispatch a_task_info.load_tasks(tasks)
      # update disabled_list
      disabled_list[time] = task_id

      count_load += 1
      _dispatch a_common.update_init_progress({
        now: count_load
      })
  # update task_info.enable_list / task_info.disabled_list
  _dispatch a_task_info.update_enable_list(enable_list)
  _dispatch a_task_info.update_disabled_list(disabled_list)
  # load done
  _dispatch a_common.update_init_progress({
    done: true
  })

module.exports = init_load_task  # async
