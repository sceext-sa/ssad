# ssad_server_api.coffee, ssad/ssad_app/ssad_file_list/src/

path = require 'path'

async_ = require './async'
config = require './config'


_app_root = (app_id) ->
  config.SERVER_ROOT + app_id + '/'

load_dir = (path_, opts) ->
  {
    root_path
    sub_root
    app_id
    ssad_key
  } = opts

  # make req url
  url = _app_root(app_id)
  key = {
    ssad_key: ssad_key
  }
  if sub_root?
    sub_path = path.relative root_path, path_
    url += sub_root + '/' + sub_path
  # else: just get app's root
  await async_.get_json url, key


module.exports = {
  load_dir  # async
}
