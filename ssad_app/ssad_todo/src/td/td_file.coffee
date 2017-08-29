# td_file.coffee, ssad/ssad_app/ssad_todo/src/td/

path = require 'path'

ssad_server_api = require '../ssad_server_api'
config = require '../config'

td_tree = require './td_tree'


# for fix filename
escape_iso_time = (raw) ->
  ("#{raw}").split(':').join('_')

unescape_iso_time = (raw) ->
  ("#{raw}").split('_').join(':')


# td path (sub_path)

path_root = ->
  td_tree.DIR_ROOT
path_task = ->
  path.join path_root(), td_tree.DIR_TASK
path_disabled = ->
  path.join path_task(), td_tree.DIR_DISABLED
path_history = ->
  path.join path_root(), td_tree.DIR_HISTORY
path_back = ->
  path.join path_root(), td_tree.DIR_BACK
path_one_history = (task_id) ->
  path.join path_history(), task_id.toString()
path_one_back = (task_id) ->
  path.join path_back(), task_id.toString()

name_disabled_task = (_time, task_id, no_suffix) ->
  o = "#{escape_iso_time _time}..#{task_id}"
  if ! no_suffix
    o = "#{o}#{td_tree.SUFFIX_TASK}"
  o

name_task = (task_id) ->
  "#{task_id}#{td_tree.SUFFIX_TASK}"
name_max_task_id = (max) ->
  "#{max}#{td_tree.SUFFIX_MAX_TASK_ID}"
name_history = (_time) ->
  "#{escape_iso_time _time}.#{td_tree.SUFFIX_HISTORY}"
name_history_hide = (_time) ->
  "#{escape_iso_time _time}.#{td_tree.SUFFIX_HISTORY_HIDE}"
name_back_task = (_time) ->
  "#{escape_iso_time _time}.#{td_tree.SUFFIX_TASK}"
name_namespace = (uuid) ->
  "#{uuid}#{td_tree.SUFFIX_UUID_NAMESPACE}"

_print_json = (data) ->
  o = JSON.stringify data  # not use pretty print
  o + '\n'


load_json = (filename) ->
  text = await ssad_server_api.load_text_file config.TD_ROOT, filename
  JSON.parse text

put_json = (filename, data) ->
  text = _print_json data
  await ssad_server_api.put_text_file config.TD_ROOT, filename, text

mv_text = (filename, to) ->
  # read old file
  text = await ssad_server_api.load_text_file config.TD_ROOT, filename
  # write new file
  await ssad_server_api.put_text_file config.TD_ROOT, to, text
  # delete old file
  await rm(filename)

rm = (filename) ->
  await ssad_server_api.rm_file config.TD_ROOT, filename

# create empty file
touch = (filename) ->
  await ssad_server_api.put_text_file config.TD_ROOT, filename, ''

list_dir = (filename) ->
  # fix filename
  if ! filename.endsWith('/')
    filename += '/'
  raw = await ssad_server_api.load_json config.TD_ROOT, filename
  # only list file (ignore dir)
  o = []
  for name of raw.dir
    if raw.dir[name].type == 'file'
      o.push name
  o


module.exports = {
  escape_iso_time
  unescape_iso_time

  path_root
  path_task
  path_disabled
  path_history
  path_back
  path_one_history
  path_one_back

  name_disabled_task
  name_task
  name_max_task_id
  name_history
  name_history_hide
  name_back_task
  name_namespace

  load_json  # async
  put_json  # async
  mv_text  # async
  rm  # async
  touch  # async
  list_dir  # async
}
