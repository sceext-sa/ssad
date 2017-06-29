# ssad_server_api.coffee, ssad/ssad_app/ssad_te/src/

async_ = require './async'


SSAD_SERVER_VERSION = '/ssad201706/pub/.ssad/version'
SSAD_SERVER_ROOT = '/ssad201706/key/'
# ssad_app: ssad_file_list
SSAD_FILE_LIST = '/ssad201706/pub/ssad_file_list/static/ssad_file_list.dev.html'


check_key = (app_id, ssad_key) ->
  url = SSAD_SERVER_ROOT + app_id + '/'
  await async_.get_json url, {
    ssad_key
  }


module.exports = {
  SSAD_SERVER_VERSION
  SSAD_SERVER_ROOT

  SSAD_FILE_LIST

  check_key  # async
}
