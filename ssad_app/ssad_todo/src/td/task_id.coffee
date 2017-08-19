# task_id.coffee, ssad/ssad_app/ssad_todo/src/td/

path = require 'path'

td_tree = require './td_tree'
td_file = require './td_file'


_remove_all_max_task_id = ->
  l = await td_file.list_dir td_file.path_task()
  for i in l
    if i.endsWith td_tree.SUFFIX_MAX_TASK_ID
      f = path.join td_file.path_task(), i
      await td_file.rm f

_check_max_task_id = (l) ->
  f = []
  for i in l
    if i.endsWith td_tree.SUFFIX_MAX_TASK_ID
      f.push i[...(i.length - td_tree.SUFFIX_MAX_TASK_ID.length)]
  if f.length < 1
    throw new Error "no max_task_id file"
  if f.length > 1
    throw new Error "too many max_task_id file  #{f}"
  # got max_task_id
  Number.parseInt f[0]

# scan and create right max_task_id
_scan_task_id = ->
  max = td_tree.DEFAULT_TASK_ID - 1
  # scan task dir
  l = await td_file.list_dir td_file.path_task()
  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      id = Number.parseInt i.split('.')[0]
      if id > max
        max = id
  # scan disabled dir
  try
    l = await td_file.list_dir td_file.path_disabled()
    for i in l
      if i.endsWith td_tree.SUFFIX_TASK
        id = Number.parseInt i.split('..')[1].split('.')[0]
        if id > max
          max = id
  catch e
    # ignore error
    console.log "task_id._scan_task_id: WARNING: #{e}  #{e.stack}"
  # create max_task_id file
  f = path.join td_file.path_task(), td_file.name_max_task_id(max)
  await td_file.touch f

_check_task_id_conflict = (task_id, ignore_error) ->
  # check task dir
  l = await td_file.list_dir td_file.path_task()
  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      id = Number.parseInt i.split('.')[0]
      if id == task_id
        throw new Error "task_id conflict #{i}"
  # check disabled dir
  try
    l = await td_file.list_dir td_file.path_disabled()
  catch e
    if ! ignore_error
      throw e
    console.log "WARNING: _check_task_id_conflict: #{e}"
    return
  for i in l
    if i.endsWith td_tree.SUFFIX_TASK
      id = Number.parseInt i.split('..')[1].split('.')[0]
      if id == task_id
        throw new Error "task_id conflict #{i}"


get_next_task_id = (ignore_error) ->
  # check td/task dir exist (robust init process)
  try
    l = await td_file.list_dir td_file.path_task()
  catch e
    console.log "WARNING: list_dir #{td_file.path_task()}  #{e.stack}"
    # create max_task_id
    max_task_id = path.join td_file.path_task(), td_file.name_max_task_id(td_tree.DEFAULT_TASK_ID - 1)
    await td_file.touch max_task_id
    # re-list dir
    l = await td_file.list_dir td_file.path_task()
  # check max_task_id
  try
    max_task_id = _check_max_task_id l
  catch e
    console.log "ERROR: bad max_task_id file  #{e.stack}"
    await _remove_all_max_task_id()

    await _scan_task_id()
    l = await td_file.list_dir td_file.path_task()
    max_task_id = _check_max_task_id l
  # new task_id
  task_id = max_task_id + 1
  # check task_id conflict
  try
    await _check_task_id_conflict task_id, true
  catch e
    if !ignore_error
      console.log "WARNING: max_task_id conflict  #{e.stack}"
    await _remove_all_max_task_id()
    await _scan_task_id()
    l = await td_file.list_dir td_file.path_task()
    max_task_id = _check_max_task_id l
    # new task_id
    task_id = max_task_id + 1
  # return new task_id
  task_id

module.exports = get_next_task_id  # async
