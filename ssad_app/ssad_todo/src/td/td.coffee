# td.coffee, ssad/ssad_app/ssad_todo/src/td/

td_file = require './td_file'

get_next_task_id = require './task_id'
load_task_and_history = require './load_task_and_history'


get_task_list = ->
  # TODO
  await return

get_disabled_list = ->
  # TODO
  await return

get_history_list = (task_id) ->
  # TODO
  await return


load_task = (task_name) ->
  # TODO
  await return

load_history = (task_id, history_name) ->
  # TODO
  await return


create_task = (data) ->
  # TODO
  await return

update_task = (data) ->
  # TODO
  await return

disable_task = (task_id, _time) ->
  # TODO
  await return

enable_task = (task_name) ->
  # TODO
  await return


create_history = (data) ->
  # TODO
  await return

hide_history = (task_id, history_name) ->
  # TODO
  await return

show_history = (task_id, history_name) ->
  # TODO
  await return


# TODO
get_uuid_namespace = ->
  # TODO
  await return


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

  get_uuid_namespace  # async  # TODO

  load_task_and_history  # async
}
