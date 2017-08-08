# td.coffee, ssad/ssad_app/ssad_todo/src/td/

td_tree = require './td_tree'
td_file = require './td_file'

get_next_task_id = require './task_id'
load_task_and_history = require './load_task_and_history'

{
  get_task_list
  get_disabled_list
  get_history_list

  load_task
  load_history

  create_task
  update_task
  disable_task
  enable_task

  create_history
  hide_history
  show_history
} = require './td_op'


get_uuid_namespace = ->
  l = await td_file.list_dir td_file.path_root()
  n = []
  for i in l
    if i.endsWith td_tree.SUFFIX_UUID_NAMESPACE
      n.push i[...(i.length - td_tree.SUFFIX_UUID_NAMESPACE.length)]
  if n.length < 1
    throw new Error "no uuid namespace"
  return n

module.exports = {
  get_next_task_id  # async

  # load list
  get_task_list  # async
  get_disabled_list  # async
  get_history_list  # async

  # load data
  load_task  # async
  load_history  # async

  # one task
  create_task  # async
  update_task  # async
  disable_task  # async
  enable_task  # async

  # one history
  create_history  # async
  hide_history  # async
  show_history  # async

  get_uuid_namespace  # async

  load_task_and_history  # async
}
