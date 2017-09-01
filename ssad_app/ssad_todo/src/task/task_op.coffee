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
  'oneshot': 'O'
  'regular': 'R'
}
_TASK_STATUS = {
  'init': 'i'
  'wait': 'w'
  'doing': 'd'
  'paused': 'p'
  'done': 'o'
  'fail': 'f'
  'cancel': 'c'
  'disabled': 's'
  'ready': 'r'
}

get_short_task_type = (type) ->
  _TASK_TYPE[type]

get_short_task_status = (status) ->
  _TASK_STATUS[status]


make_group = (history_list, history) ->
  o = {
    history: {}
    group: [
      # {
      #   hide: false  # or true
      #   hide_show: false  # hide_show for whole group
      #   history: [ HISTORY_NAME ]
      # }
    ]
  }
  loaded_history = Object.keys history
  loaded_history.sort()
  loaded_history.reverse()  # latest history first

  if loaded_history.length < 1
    return o
  # div group
  group = {
    hide: null
    history: []
  }
  for history_name in loaded_history
    # init hide value
    if ! group.hide?
      group.hide = history_list[history_name]

    if history_list[history_name] == group.hide
      group.history.push history_name
    else  # reset group
      o.group.push group
      # new group already with one item
      group = {
        hide: history_list[history_name]
        history: [
          history_name
        ]
      }
  # check last group
  if group.history.length > 0
    o.group.push group

  # clean hide groups, based on history
  for i in [0... o.group.length]
    g = o.group[i]
    if ! g.hide
      # set all items to false (not enable hide_show)
      for j in g.history
        o.history[j] = false
      continue

    count_hide_show = 0
    for j in g.history
      if history[j]
        count_hide_show += 1
    # check clean
    if count_hide_show > (g.history.length / 2)
      # show all in this group
      for j in g.history
        o.history[j] = true
      g.hide_show = true
    else
      # hide all in this group
      for j in g.history
        o.history[j] = false
      g.hide_show = false
  o


module.exports = {
  check_task_data  # throw
  check_task_id  # throw

  get_short_task_type
  get_short_task_status

  make_group
}
