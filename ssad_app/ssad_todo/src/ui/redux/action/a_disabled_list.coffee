# a_disabled_list.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

config = require '../../../config'

td = require '../../../td/td'
a_td = require './a_td'


# action types

DL_LOAD_MORE_TASKS = 'dl_load_more_tasks'


load_more_tasks = ->
  (dispatch, getState) ->
    dispatch {
      type: DL_LOAD_MORE_TASKS
    }

    $$td = getState().td

    all_list = $$td.get('disabled_list').toJS()
    to_load = []
    for i in all_list
      p = i.split '..'  # ISO_TIME..TASK_ID
      task_id = Number.parseInt p[1]
      if ! $$td.getIn(['task', task_id])?
        to_load.push i  # not loaded
    # sort task by time
    to_load.sort()
    to_load.reverse()  # latest items first

    # TODO show doing operate ?

    # load each task items
    for i in [0... config.LOAD_MORE_ONCE_N]
      if i >= to_load.length
        break
      p = to_load[i].split '..'
      task_name = td.make_disabled_task_name p[1], p[0]

      await dispatch a_td.load_task(task_name)
    # load done


module.exports = {
  DL_LOAD_MORE_TASKS

  load_more_tasks  # thunk
}
