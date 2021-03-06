# r_td.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

task_calc = require '../../../task/task_calc'

state = require '../state'
ac = require '../action/a_td'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.td
  $$o

# update one task calc attr
_calc_task = ($$o, task_id) ->
  # task current status
  $$data = $$o.getIn(['task', task_id])
  if ! $$data?
    return $$o

  enable_list = $$o.get('task_list').toJS()
  calc = task_calc.calc_one_task task_id, $$data.toJS(), enable_list

  $$o = $$o.setIn ['task', task_id, 'calc'], Immutable.fromJS(calc)
  $$o


# $$state: state.td
reducer = ($$state, action) ->
  $$o = _check_init_state $$state

  no_calc = $$o.get 'no_calc'
  _check_calc = ($$o, task_id) ->
    if ! no_calc
      $$o = _calc_task $$o, task_id
    $$o
  _calc_all_task = ($$o, enable_list) ->
    if ! no_calc
      for i in enable_list
        $$o = _calc_task $$o, i
    $$o

  switch action.type
    when ac.TD_UPDATE_NEXT_TASK_ID
      $$o = $$o.set 'next_task_id', action.payload
    when ac.TD_UPDATE_DISABLED_LIST
      $$data = Immutable.fromJS action.payload
      $$o = $$o.set 'disabled_list', $$data
    when ac.TD_CALC_ALL
      enable_list = $$o.get('task_list').toJS()
      $$o = _calc_all_task $$o, enable_list
    when ac.TD_CALC_TASK
      $$o = _check_calc $$o, action.payload

    when ac.TD_UPDATE_TASK_LIST
      $$data = Immutable.fromJS action.payload
      $$o = $$o.set 'task_list', $$data
      # update all tasks
      $$o = _calc_all_task $$o, action.payload

    when ac.TD_UPDATE_HISTORY_LIST
      $$data = Immutable.fromJS action.payload.data
      # task must exist (loaded before)
      $$o = $$o.setIn ['task', action.payload.task_id, 'history_list'], $$data

      $$o = _check_calc $$o, action.payload.task_id

    when ac.TD_UPDATE_TASK
      task_id = action.payload.task_id
      # check task already exist
      if $$o.getIn(['task', task_id])?
        # exist, only update raw
        $$data = Immutable.fromJS action.payload.data
        $$o = $$o.setIn ['task', task_id, 'raw'], $$data
      else  # not exist, create a new task
        raw = action.payload.data
        one_task = {
          raw
          history: {}
          history_list: {}
          calc: null  # null for check error
        }
        # force init calc task
        one_task.calc = task_calc.calc_one_task task_id, one_task, []

        $$data = Immutable.fromJS one_task
        $$o = $$o.setIn ['task', task_id], $$data
      $$o = _check_calc $$o, task_id

    when ac.TD_UPDATE_HISTORY
      $$data = Immutable.fromJS action.payload.data
      # task must exist
      $$o = $$o.setIn ['task', action.payload.task_id, 'history', action.payload.history_name], $$data

      $$o = _check_calc $$o, action.payload.task_id

    when ac.TD_SET_NO_CALC
      $$o = $$o.set 'no_calc', action.payload
    #else: ignore
  $$o

module.exports = reducer
