# task_op.coffee, ssad/ssad_app/ssad_todo/src/task/

task_check = require './task_check'


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


module.exports = {
  make_load_task_and_history
  get_task_last_update_time
  check_task_data  # throw
}
