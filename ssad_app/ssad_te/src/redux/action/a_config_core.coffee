# a_config_core.coffee, ssad/ssad_app/ssad_te/src/redux/action/

a_common = require './a_common'
core_editor = require '../../core_editor'
util = require '../../util'

# action types

CONFIG_CORE_SET_CORE = 'config_core_set_core'


set_core = (core_name) ->
  (dispatch, getState) ->
    # switch core editor
    core_editor.set_core core_name
    # reset clean
    core_editor.mark_clean()
    # set active
    switch core_name
      when core_editor.CORE_EDITOR_CODEMIRROR
        util.set_core_active_cm()
      when core_editor.CORE_EDITOR_ACE
        util.set_core_active_ace()
    # FIXME reset clean
    dispatch a_common.set_doc_clean(true)

    dispatch {
      type: CONFIG_CORE_SET_CORE
      payload: core_name
    }
    await return

module.exports = {
  CONFIG_CORE_SET_CORE

  set_core  # thunk
}
