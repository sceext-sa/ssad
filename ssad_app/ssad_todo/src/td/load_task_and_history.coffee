# load_task_and_history.coffee, ssad/ssad_app/ssad_todo/src/td/

config = require '../config'

{
  get_history_list
  load_task
  load_history
} = require './td_op'


# can not load history of disabled task
load_task_and_history = (task_id, limit_n) ->
  if ! limit_n?
    limit_n = config.DEFAULT_LOAD_HISTORY_N
  # load the task
  task = await td_op.load_task task_id

  l = await td_op.get_history_list task_id
  # sort history name
  name = Object.keys l
  name.sort()
  name.reverse()  # load latest history item first

  history = {}  # loaded history
  # load each history
  count = 0
  status = null  # task status in history
  for i in name
    one = await td_op.load_history task_id, i
    # save data
    history[i] = one

    if one.data.status?
      status = one.data.status
    count += 1
    # check break
    if (count > limit_n) and status?
      break  # load until got first status
  # load one task (and history) done
  {
    task
    history
    hide: l
  }

module.exports = load_task_and_history  # async
