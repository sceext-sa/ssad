# task.coffee, ssad/ssad_app/ssad_todo/src/task/

task_check = require './task_check'

{
  check_task_data
  check_task_id
} = require './task_op'


module.exports = {
  check_task_data  # throw
  check_task_id  # throw

  check_form: task_check.check_form
}
