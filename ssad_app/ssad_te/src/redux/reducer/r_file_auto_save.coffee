# r_file_auto_save.coffee, ssad/ssad_app/ssad_te/src/redux/reducer/

Immutable = require 'immutable'

ac = require '../action/a_file_auto_save'


# $$o = state.main.auto_save
reducer = ($$o, action) ->
  switch action.type
    when ac.AUTO_SAVE_SET_ENABLE
      $$o = $$o.set 'enable', action.payload
    when ac.AUTO_SAVE_SET_LAST_CLEAN_MARK
      $$o = $$o.set '_last_clean_mark', action.payload
    when ac.AUTO_SAVE_LOG
      $$o = $$o.update 'logs', ($$logs) ->
        $$logs.push action.payload
    when ac.AUTO_SAVE_TRY_SAVE
      # update last_time
      $$o = $$o.set 'last_time', action.payload
  $$o

module.exports = reducer
