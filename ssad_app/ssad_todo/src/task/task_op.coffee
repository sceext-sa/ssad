# task_op.coffee, ssad/ssad_app/ssad_todo/src/task/

task_check = require './task_check'

# for create/edit task
check_task_data = (raw) ->
  # skip: type
  # title
  if raw.title.trim() is ''
    throw new Error "empty title: #{raw.title}"
  # skip: desc
  # check time.{ planned_start, ddl, duration_limit, auto_ready }
  if raw.time.planned_start.trim() != ''
    task_check.check_time_planned_start raw.time.planned_start
  if raw.time.ddl.trim() != ''
    task_check.check_time_ddl raw.time.ddl
  if raw.time.duration_limit.trim() != ''
    task_check.check_time_duration_limit raw.time.duration_limit
  if raw.time.auto_ready.trim() != ''
    task_check.check_time_auto_ready raw.time.auto_ready
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

check_task_id = (id) ->
  if ! id?
    throw new Error "no task_id: #{id}"
  task_id = Number.parseInt id
  if Number.isNaN task_id
    throw new Error "task_id NaN: #{id}"
  if task_id < 1
    throw new Error "bad task_id: #{id}"


# for render tasks

_TASK_TYPE = {
  'oneshot': 'o'
  'regular': 'r'
}
_TASK_STATUS = {
  'init': 'I'
  'wait': 'W'
  'doing': 'D'
  'paused': 'P'
  'done': 'O'
  'fail': 'F'
  'cancel': 'C'
  'disabled': 'S'
}

get_short_task_type = (type) ->
  _TASK_TYPE[type]

get_short_task_status = (status) ->
  _TASK_STATUS[status]


module.exports = {
  check_task_data  # throw
  check_task_id  # throw

  get_short_task_type
  get_short_task_status
}
