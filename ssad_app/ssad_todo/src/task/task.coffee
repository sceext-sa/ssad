# task.coffee, ssad/ssad_app/ssad_todo/src/task/

init_load_task = require './init_load_task'

{
  make_load_task_and_history
} = require './task_op'


module.exports = {
  make_load_task_and_history

  init_load_task  # async
}
