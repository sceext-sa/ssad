# ssad_server_api.coffee, ssad/ssad_app/ssad_todo/src/

path = require 'path'

async_ = require './async'
config = require './config'


SSAD_SERVER_ROOT = '/ssad201706/key/'
SSAD_SERVER_VERSION = '/ssad201706/pub/.ssad/version'


get_version = ->
  await async_.get_json SSAD_SERVER_VERSION, {}

check_key = (app_id, ssad_key) ->
  url = SSAD_SERVER_ROOT + app_id + '/'
  await async_.get_json url, {
    ssad_key
  }

load_text_file = (app_id, ssad_key, sub_root, sub_path) ->
  base = SSAD_SERVER_ROOT + app_id + '/'
  url = path.join base, sub_root, sub_path
  await async_.get_text url, {
    ssad_key
  }

put_text_file = (app_id, ssad_key, sub_root, sub_path, text) ->
  base = SSAD_SERVER_ROOT + app_id + '/'
  url = path.join base, sub_root, sub_path
  await async_.put_text url, {
    ssad_key
  }

rm_file = (TODO) ->
  # TODO

list_dir = (TODO) ->
  # TODO

# TODO support move ?

module.exports = {
  get_version  # async
  check_key  # async

  load_text_file  # async
  put_text_file  # async
  rm_file  # async
  list_dir  # async
}
