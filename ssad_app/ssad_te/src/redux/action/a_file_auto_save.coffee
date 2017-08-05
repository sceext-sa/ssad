# a_file_auto_save.coffee, ssad/ssad_app/ssad_te/src/redux/action/

# TODO

# action types

AUTO_SAVE_SET_ENABLE = 'auto_save_set_enable'
AUTO_SAVE_SET_LAST_CLEAN_MARK = 'auto_save_set_last_clean_mark'
AUTO_SAVE_LOG = 'auto_save_log'
AUTO_SAVE_TRY_SAVE = 'auto_save_try_save'


set_enable = (enable) ->
  {
    type: AUTO_SAVE_SET_ENABLE
    payload: enable
  }

set_last_clean_mark = (mark) ->
  {
    type: AUTO_SAVE_SET_LAST_CLEAN_MARK
    payload: mark
  }

log = (text) ->
  {
    type: AUTO_SAVE_LOG
    payload: text
  }

try_save = ->
  (dispatch, getState) ->
    # TODO

    last_time = null  # TOdO
    dispatch {
      type: AUTO_SAVE_TRY_SAVE
      payload: last_time
    }
    await return

module.exports = {
  AUTO_SAVE_SET_ENABLE
  AUTO_SAVE_SET_LAST_CLEAN_MARK
  AUTO_SAVE_LOG
  AUTO_SAVE_TRY_SAVE

  set_enable
  set_last_clean_mark
  log
  try_save  # thunk
}
