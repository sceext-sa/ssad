# ssad_server_api.coffee, ssad/ssad_app/ssad_te/src/

path = require 'path'

async_ = require './async'


SSAD_SERVER_VERSION = '/ssad201706/pub/.ssad/version'
SSAD_SERVER_ROOT = '/ssad201706/key/'
# ssad_app: ssad_file_list
SSAD_FILE_LIST = '/ssad201706/pub/ssad_file_list/static/ssad_file_list.dev.html'


get_version = ->
  await async_.get_json SSAD_SERVER_VERSION, {}

check_key = (app_id, ssad_key) ->
  url = SSAD_SERVER_ROOT + app_id + '/'
  await async_.get_json url, {
    ssad_key
  }

make_url = (app_id, sub_root, sub_path, filename) ->
  o = SSAD_SERVER_ROOT + app_id + '/'
  o = path.join o, sub_root, sub_path, filename

load_text_file = (url, ssad_key) ->
  await async_.get_text url, {
    ssad_key
  }

put_text_file = (url, ssad_key, text) ->
  await async_.put_text url, {
    ssad_key
  }, text


module.exports = {
  SSAD_SERVER_VERSION
  SSAD_SERVER_ROOT

  SSAD_FILE_LIST

  get_version  # async
  check_key  # async

  make_url
  load_text_file  # async
  put_text_file  # async
}
