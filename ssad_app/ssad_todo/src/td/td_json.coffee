# td_json.coffee, ssad/ssad_app/ssad_todo/src/td/

TD_JSON_VERSION = '0.1.0'

create_json = (data, _time) ->
  {  # TD_JSON common struct
    version: TD_JSON_VERSION
    _time
    data
  }

module.exports = {
  TD_JSON_VERSION

  create_json
}
