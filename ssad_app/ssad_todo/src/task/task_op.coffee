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

module.exports = {
  make_load_task_and_history
}
