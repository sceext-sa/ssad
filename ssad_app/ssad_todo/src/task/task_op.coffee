# task_op.coffee, ssad/ssad_app/ssad_todo/src/task/


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


module.exports = {
  make_load_task_and_history
  get_task_last_update_time
}
