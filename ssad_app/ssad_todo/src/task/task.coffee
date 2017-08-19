# task.coffee, ssad/ssad_app/ssad_todo/src/task/

init_load_task = require './init_load_task'

{
  make_load_task_and_history
  get_task_last_update_time
  check_task_data

  create_task
} = require './task_op'


module.exports = {
  make_load_task_and_history
  get_task_last_update_time
  check_task_data  # throw

  init_load_task  # async

  create_task  # async
}
