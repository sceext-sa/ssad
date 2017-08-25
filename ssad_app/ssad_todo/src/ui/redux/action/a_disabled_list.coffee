# a_disabled_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

# action types

DL_LOAD_MORE_TASKS = 'dl_load_more_tasks'


load_more_tasks = ->
  (dispatch, getState) ->
    dispatch {
      type: DL_LOAD_MORE_TASKS
    }
    # TODO
    await return

module.exports = {
  DL_LOAD_MORE_TASKS

  load_more_tasks  # thunk
}
