# a_count.coffee, ssad/ssad_app/ssad_te/src/redux/action/

core_editor = require '../../core_editor'
count = require '../../count'

# action types

COUNT_REFRESH = 'count_refresh'
COUNT_SET_MAIN = 'count_set_main'


set_main = (main) ->
  {
    type: COUNT_SET_MAIN
    payload: main
  }

refresh = ->
  (dispatch, getState) ->
    # count text
    text = core_editor.get_text()
    if ! text?
      text = ''
    info = count text
    # update count info
    dispatch {
      type: COUNT_REFRESH
      payload: info
    }
    await return

module.exports = {
  COUNT_REFRESH
  COUNT_SET_MAIN

  set_main
  refresh  # thunk
}
