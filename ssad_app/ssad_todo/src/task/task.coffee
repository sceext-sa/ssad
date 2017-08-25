# task.coffee, ssad/ssad_app/ssad_todo/src/task/

task_check = require './task_check'

{
  check_task_data
  check_task_id

  get_short_task_type
  get_short_task_status
} = require './task_op'


module.exports = {
  check_task_data  # throw
  check_task_id  # throw

  check_form: task_check.check_form
  check_task_change: task_check.check_task_change  # throw

  get_short_task_type
  get_short_task_status
}
