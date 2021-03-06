# td_op.coffee, ssad/ssad_app/ssad_todo/src/td/

path = require 'path'

td_tree = require './td_tree'
td_file = require './td_file'

get_next_task_id = require './task_id'


get_task_list = ->
  o = []
  try
    l = await td_file.list_dir td_file.path_task()
  catch e
    # ignore errors such as 404
    console.log "ERROR: td.get_task_list  #{e}: #{e.stack}"
    return o
  if ! l?  # l  maybe undefined
    return o

  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      t = Number.parseInt i[...(i.length - td_tree.SUFFIX_TASK.length)]
      o.push t
  o  # [ TASK_ID ]

get_disabled_list = ->
  o = []
  try
    l = await td_file.list_dir td_file.path_disabled()
  catch e
    # ignore errors such as 404
    console.log "ERROR: td.get_disabled_list  #{e}: #{e.stack}"
    return o
  if ! l?  # l  maybe undefined
    return o

  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      one = i[...(i.length - td_tree.SUFFIX_TASK.length)]
      o.push td_file.unescape_iso_time(one)
  o  # [ ISO_TIME..TASK_ID ]

get_history_list = (task_id) ->
  # NOTE no history is a error
  l = await td_file.list_dir td_file.path_one_history(task_id)

  _name = (raw) ->
    td_file.unescape_iso_time(raw.split('..')[0])

  o = {}
  for i in l
    if i.endsWith td_tree.SUFFIX_HISTORY
      name = _name i
      o[name] = false  # hide: false
  for i in l
    if i.endsWith td_tree.SUFFIX_HISTORY_HIDE
      name = _name i
      if o[name]?
        o[name] = true  # hide: true
      # else: ignore error
  o  # { ISO_TIME : HIDE }


# load enabled/disabled task the same way
load_task = (task_name) ->
  filename = path.join td_file.path_task(), td_file.name_task(task_name)
  await td_file.load_json filename

load_history = (task_id, _time) ->
  filename = path.join td_file.path_one_history(task_id), td_file.name_history(_time)
  await td_file.load_json filename


create_task = (data) ->
  task_id = data.data.task_id
  # check task_id conflict
  l = await td_file.list_dir td_file.path_task()
  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      id = Number.parseInt i.split('.')[0]
      if id == task_id
        throw new Error "task_id conflict #{task_id}"
  l = await get_disabled_list()
  for i in l
    id = Number.parseInt i.split('..')[1].split('.')[0]
    if id == task_id
      throw new Error "task_id conflict #{task_id} (disabled) #{i}"
  # create new task file
  filename = path.join td_file.path_task(), td_file.name_task(task_id)
  await td_file.put_json filename, data
  # update max_task_id
  await get_next_task_id(true)  # ignore_error: true  # TODO improve performance (avoid scan)
  # create back file
  filename = path.join td_file.path_one_back(task_id), td_file.name_back_task(data._time)
  await td_file.put_json filename, data

_check_task_exist = (task_id, not_exist) ->
  l = await td_file.list_dir td_file.path_task()
  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      id = Number.parseInt i.split('.')[0]
      if id == task_id
        if not_exist
          throw new Error "task #{task_id} exist"
        return  # check pass
  if !not_exist
    throw new Error "task #{task_id} not exist"

_check_disabled_task_exist = (task_id, not_exist) ->
  f = []
  l = []
  try
    l = await td_file.list_dir td_file.path_disabled()
  catch e
    console.log "WARNING: td_op._check_disabled_task_exist: #{e}  #{e.stack}"

  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      id = Number.parseInt i.split('..')[1].split('.')[0]
      if id == task_id
        f.push i
  # check id number
  if not_exist
    if f.length == 1
      throw new Error "disabled task #{task_id} exist"
  else
    if f.length < 1
      throw new Error "disabled task #{task_id} not exist"
    if f.length > 1
      throw new Error "too many disabled task #{task_id}"
    return f[0]

update_task = (data) ->
  task_id = data.data.task_id
  await _check_task_exist task_id
  # update json file
  filename = path.join td_file.path_task(), td_file.name_task(task_id)
  await td_file.put_json filename, data
  # create back file
  filename = path.join td_file.path_one_back(task_id), td_file.name_back_task(data._time)
  await td_file.put_json filename, data

disable_task = (task_id, _time) ->
  # check already disabled
  await _check_disabled_task_exist task_id, true  # throw if exist

  await _check_task_exist task_id  # throw if not exist
  # move file
  filename = path.join td_file.path_task(), td_file.name_task(task_id)
  to = path.join td_file.path_disabled(), td_file.name_disabled_task(_time, task_id)
  await td_file.mv_text filename, to

enable_task = (task_id) ->
  # check already enabled
  await _check_task_exist task_id, true  # throw if exist

  f = await _check_disabled_task_exist task_id  # throw if not exist
  # move file
  filename = path.join td_file.path_disabled(), f
  to = path.join td_file.path_task(), td_file.name_task(task_id)
  await td_file.mv_text filename, to


create_history = (data) ->
  task_id = data.data.task_id
  # create history file
  filename = path.join td_file.path_one_history(task_id), td_file.name_history(data._time)
  await td_file.put_json filename, data

hide_history = (task_id, _time) ->
  # TODO check already hide ?
  # create hide flag
  filename = path.join td_file.path_one_history(task_id), td_file.name_history_hide(_time)
  await td_file.touch filename

show_history = (task_id, _time) ->
  # remove hide flag
  filename = path.join td_file.path_one_history(task_id), td_file.name_history_hide(_time)
  await td_file.rm filename

module.exports = {
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
}
