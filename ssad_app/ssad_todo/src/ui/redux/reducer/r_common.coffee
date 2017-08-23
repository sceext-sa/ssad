# r_common.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/a_common'
# sub reducers
r_welcome = require './r_welcome'
r_task_info = require './r_task_info'
r_edit_create_task = require './r_edit_create_task'
r_enable_task_list = require './r_enable_task_list'
# TODO


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
    when ac.COMMON_SET_OP_DOING
      $$o = $$o.set 'op_doing', action.payload
    when ac.COMMON_SET_TASK_ID
      $$o = $$o.set 'task_id', action.payload
    when ac.COMMON_SET_IS_CREATE_TASK
      $$o = $$o.set 'is_create_task', action.payload

    else  # call sub reducers
      $$o = r_welcome $$o, action
      $$o = $$o.update 'task_info', ($$t) ->
        r_task_info $$t, action
      $$o = $$o.update 'edit_task', ($$e) ->
        r_edit_create_task $$e, action
      $$o = r_enable_task_list $$o, action
  $$o

module.exports = reducer
