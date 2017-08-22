# task_op.coffee, ssad/ssad_app/ssad_todo/src/task/

config = require '../config'
a_task_info = require '../ui/redux/action/a_task_info'
td = require '../td/td'
one_task = require '../td/one_task'
one_history = require '../td/one_history'

task_check = require './task_check'


_dispatch = (action) ->
  config.store().dispatch action

# TODO check task data right ?  (such task_id ?)
make_load_task_and_history = (data) ->
  o = {
    raw: data.task
    history: {}
  }
  # build history list
  for name of data.history
    one = {
      raw: data.history[name]
      hide: data.hide[name]
    }
    o.history[name] = one
  o

get_task_last_update_time = (raw) ->
  # NOTE each task has at least one history item
  h = raw.history
  time_list = Object.keys h
  time_list.sort()
  time_list.reverse()  # latest item
  time_list[0]

# for create/edit task
check_task_data = (raw) ->
  # check task_id
  if ! raw.task_id?
    throw new Error "no task_id: #{raw.task_id}"
  task_id = Number.parseInt raw.task_id
  if Number.isNaN task_id
    throw new Error "task_id NaN: #{raw.task_id}"
  # skip: type
  # title
  if raw.title.trim() is ''
    throw new Error "empty title: #{raw.title}"
  # skip: desc
  # check time.{ planned_start, ddl, duration_limit }
  if raw.time.planned_start.trim() != ''
    task_check.check_time_planned_start raw.time.planned_start
  if raw.time.ddl.trim() != ''
    task_check.check_time_ddl raw.time.ddl
  if raw.time.duration_limit.trim() != ''
    task_check.check_time_duration_limit raw.time.duration_limit
  # check task type
  switch raw.type
    when 'regular'
      # check time.interval
      if raw.time.interval.trim() is ''
        throw new Error "empty time.interval: #{raw.time.interval}"
      # check time.interval content
      task_check.check_time_interval raw.time.interval
      # skip: time_base
    #when 'oneshot'  # skip
    #else: skip
  # check done (pass)


create_task = (raw) ->
  # make task data
  opt = {
    time: {
      planned_start: null
      ddl: null
      duration_limit: null
      interval: null
    }
    time_base: null
  }
  if raw.time.planned_start?
    t = raw.time.planned_start.trim()
    if t != ''
      opt.time.planned_start = t
  if raw.time.ddl?
    t = raw.time.ddl.trim()
    if t != ''
      opt.time.ddl = t
  if raw.time.duration_limit?
    t = raw.time.duration_limit.trim()
    if t != ''
      opt.time.duration_limit = t
  if raw.time.interval?
    t = raw.time.interval.trim()
    if t != ''
      opt.time.interval = t
  if raw.time_base?
    t = raw.time_base.trim()
    if t != ''
      opt.time_base = t

  {
    task_id
    type
    title
    desc
  } = raw
  data = one_task.create_task task_id, type, title, desc, opt
  await td.create_task data
  # create task create history
  data = one_history.create_history task_id, one_history.TYPE_CREATE
  await td.create_history data
  # NOTE task in enabled by default
  # auto load the task after create
  raw = await td.load_task_and_history task_id
  one = make_load_task_and_history raw
  tasks = {}
  tasks[task_id] = one
  _dispatch a_task_info.load_tasks(tasks)
  # update enable_list
  last_time = get_task_last_update_time one
  enable_list = {}
  enable_list[last_time] = task_id

  _dispatch a_task_info.update_enable_list(enable_list)


module.exports = {
  make_load_task_and_history
  get_task_last_update_time
  check_task_data  # throw

  create_task  # async
}
