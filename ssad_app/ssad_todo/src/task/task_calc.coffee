# task_calc.coffee, ssad/ssad_app/ssad_todo/src/task/

task_status = require '../td/task_status'


_make_history_index = (data) ->
  history_name = Object.keys data.history
  history_name.sort()
  history_name.reverse()  # latest history first
  history_name


# get current status of one task from history items
get_current_status = (data) ->
  for i in _make_history_index(data)
    h = data.history[i]
    if h.data.status?
      return h.data.status
  # no history item has `status`
  task_status.INIT

# get latest task comment, or task desc
get_latest_text = (data) ->
  for i in _make_history_index(data)
    h = data.history[i]
    if h.data.note?
      return h.data.note
  # no 'note' history, use task desc
  desc = data.raw.data.desc
  if ! desc?
    desc = ''  # use empty str
  desc

# task last update time, for sort task
get_last_time = (data) ->
  # get all history time
  ht = Object.keys data.history_list
  # add one: task raw last_update time
  ht.push data.raw._time
  # sort time
  ht.sort()
  ht.reverse()  # use latest one
  ht[0]


module.exports = {
  get_current_status
  get_latest_text
  get_last_time
}
