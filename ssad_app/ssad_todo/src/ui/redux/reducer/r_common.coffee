# r_common.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_common'
# sub reducers
r_welcome = require './r_welcome'
r_edit_create_task = require './r_edit_create_task'
r_enable_task_list = require './r_enable_task_list'
r_one_task = require './r_one_task'
r_change_status = require './r_change_status'
r_config = require './r_config'


_check_init_state = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state.main
  $$o

# $$state: state.main
reducer = ($$state, action) ->
  $$o = _check_init_state $$state
  switch action.type
    when ac.COMMON_UPDATE_INIT_PROGRESS
      $$data = Immutable.fromJS action.payload
      $$o = $$o.update 'init_load_progress', ($$p) ->
        $$p.merge $$data
    when ac.COMMON_INIT_LOAD_ADD_ONE
      $$o = $$o.updateIn ['init_load_progress', 'now'], (now) ->
        now + 1

    when ac.COMMON_SET_OP_DOING
      $$o = $$o.set 'op_doing', action.payload
    when ac.COMMON_SET_TASK_ID
      $$o = $$o.set 'task_id', action.payload
    when ac.COMMON_SET_IS_CREATE_TASK
      $$o = $$o.set 'is_create_task', action.payload

    else  # call sub reducers
      $$o = r_welcome $$o, action
      $$o = $$o.update 'edit_task', ($$e) ->
        r_edit_create_task $$e, action
      $$o = r_enable_task_list $$o, action
      $$o = r_one_task $$o, action
      $$o = $$o.update 'cs', ($$c) ->
        r_change_status $$c, action
      $$o = $$o.update 'config', ($$c) ->
        r_config $$c, action
  $$o

module.exports = reducer
