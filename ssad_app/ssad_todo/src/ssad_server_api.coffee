# ssad_server_api.coffee, ssad/ssad_app/ssad_todo/src/

path = require 'path'

async_ = require './async'
config = require './config'


SSAD_SERVER_ROOT = '/ssad201706/key/'
SSAD_SERVER_VERSION = '/ssad201706/pub/.ssad/version'


# global storage
_etc = {
  app_id: null
  ssad_key: null
}

# get/set
app_id = (i) ->
  if i?
    _etc.app_id = i
  _etc.app_id
ssad_key = (k) ->
  if k?
    _etc.ssad_key = k
  _etc.ssad_key


get_version = ->
  await async_.get_json SSAD_SERVER_VERSION, {}


_base_url = ->
  SSAD_SERVER_ROOT + app_id() + '/'

_key = ->
  {
    ssad_key: ssad_key()
  }


check_key = ->
  await async_.get_json _base_url(), _key()

load_text_file = (sub_root, sub_path) ->
  url = path.join _base_url(), sub_root, sub_path
  await async_.get_text url, _key()

put_text_file = (sub_root, sub_path, text) ->
  url = path.join _base_url(), sub_root, sub_path
  await async_.put_text url, _key()

rm_file = (sub_root, sub_path) ->
  url = path.join _base_url(), sub_root, sub_path
  await async_.rm_file url, _key()

load_json = (sub_root, sub_path) ->
  url = path.join _base_url(), sub_root, sub_path
  await async_.get_json url, _key()


# TODO support move ?

module.exports = {
  app_id  # get/set
  ssad_key  # get/set

  get_version  # async
  check_key  # async

  load_text_file  # async
  put_text_file  # async
  rm_file  # async
  load_json  # async
}
