# a_task.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/action/

config = require '../../../config'
thread_pool = require '../../../task/thread_pool'

td = require '../../../td/td'
one_task = require '../../../td/one_task'
one_history = require '../../../td/one_history'
task_status = require '../../../td/task_status'
a_td = require './a_td'
a_common = require './a_common'
a_config = require './a_config'

# action types

# load data
T_INIT_LOAD = 't_init_load'
T_LOAD_ONE_TASK = 't_load_one_task'  # load task and history

# modify (update) data (task)
T_CREATE_TASK = 't_create_task'
T_UPDATE_TASK = 't_update_task'
T_DISABLE_TASK = 't_disable_task'
T_ENABLE_TASK = 't_enable_task'
T_CHANGE_STATUS = 't_change_status'
T_ADD_COMMENT = 't_add_comment'
T_HIDE_HISTORY = 't_hide_history'
T_SHOW_HISTORY = 't_show_history'


init_load = ->
  (dispatch, getState) ->
    dispatch {
      type: T_INIT_LOAD
    }
    # `no_calc` is enabled by default

    # DEBUG load time
    start = new Date()
    console.log "DEBUG: init_load start at #{start.toISOString()}"

    # load (enabled) task list and disabled (task) list first
    await dispatch a_td.load_task_list()
    await dispatch a_td.load_disabled_list()
    await dispatch a_td.load_next_task_id()  # load next task_id now

    $$td = getState().td
    enable_list = $$td.get('task_list').toJS()
    disabled_list = $$td.get('disabled_list').toJS()
    # to-load count
    count_to_load_disabled = disabled_list.length
    if count_to_load_disabled > config.DEFAULT_LOAD_DISABLED_N
      count_to_load_disabled = config.DEFAULT_LOAD_DISABLED_N
    count_to_load = enable_list.length + count_to_load_disabled
    dispatch a_common.update_init_progress({
      all: count_to_load
      done: false
      now: 0
      error: null  # reset error
    })
    # TODO more error progress ?

    # multi-thread load enable tasks
    console.log "DEBUG: init_load with #{config.INIT_LOAD_THREAD_N} threads"
    pool = thread_pool config.INIT_LOAD_THREAD_N

    _worker_enable = (task_id) ->
      try
        await dispatch load_one_task(task_id)
        # load OK, +1
        dispatch a_common.init_load_add_one()
      catch e
        error = "load task #{task_id}, #{e}  #{e.stack}"
        dispatch a_common.update_init_progress({
          error
        })
    # load all enable tasks (with default number of history items)
    await pool.run enable_list, _worker_enable

    # sort disabled tasks
    disabled_list.sort()  # ISO_TIME..TASK_ID
    disabled_list.reverse()  # load latest items first
    # make todo_list
    todo_list = []
    for i in [0... config.DEFAULT_LOAD_DISABLED_N]
      if i >= disabled_list.length
        break
      p = disabled_list[i].split '..'  # ISO_TIME..TASK_ID
      task_name = td.make_disabled_task_name p[1], p[0]

      todo_list.push task_name
    # multi-thread load disabled tasks
    console.log "DEBUG: init_load: load #{todo_list.length} disabled tasks"
    pool = thread_pool config.INIT_LOAD_THREAD_N

    _worker_disabled = (task_name) ->
      try
        await dispatch a_td.load_task(task_name)
        # load OK, +1
        dispatch a_common.init_load_add_one()
      catch e
        error = "load task #{task_name}: #{e}  #{e.stack}"
        dispatch a_common.update_init_progress({
          error
        })
    # load disabled tasks
    await pool.run todo_list, _worker_disabled

    # DEBUG init load time
    end = new Date()
    console.log "DEBUG: init_load end at #{end.toISOString()}"
    time_used = end.getTime() - start.getTime()
    console.log "DEBUG: init_load used time #{time_used / 1e3}s"
    # update config
    dispatch a_config.set_init_load_thread_n(config.INIT_LOAD_THREAD_N)
    dispatch a_config.set_init_load_time_s(time_used / 1e3)

    # turn-off no_calc
    dispatch a_td.set_no_calc(false)
    dispatch a_td.calc_all()  # update all data
    # load done
    dispatch a_common.update_init_progress({
      done: true
    })

# can not load history of disabled task
load_one_task = (task_id, limit_n) ->
  (dispatch, getState) ->
    if ! limit_n?
      limit_n = config.DEFAULT_LOAD_HISTORY_N

    dispatch {
      type: T_LOAD_ONE_TASK
      payload: {  # for DEBUG
        task_id
        limit_n
      }
    }
    # load the task and history list
    await dispatch a_td.load_task(task_id)
    await dispatch a_td.load_history_list(task_id)

    $$td = getState().td
    l = $$td.getIn(['task', task_id, 'history_list']).toJS()
    # sort history name
    name = Object.keys l
    name.sort()
    name.reverse()  # load latest history item first
    # load each history
    count = 0
    status = null  # task status in history
    for i in name
      await dispatch a_td.load_history(task_id, i)
      $$td = getState().td
      h = $$td.getIn(['task', task_id, 'history', i]).toJS()
      if h.data.status?
        status = h.data.status
      count += 1

      _is_last_end = (status) ->
        status? and (task_status.CLASS_END.indexOf(status) != -1)

      # check break
      if (count > limit_n) and _is_last_end(status)
        break  # load until last_end
    # load one task (and history) done


_make_task_data = (task_id, raw) ->
  opt = {
    time: {
      planned_start: null
      ddl: null
      duration_limit: null
      interval: null
    }
    time_base: null
  }
  if raw.time.planned_start?
    t = raw.time.planned_start.trim()
    if t != ''
      opt.time.planned_start = t
  if raw.time.ddl?
    t = raw.time.ddl.trim()
    if t != ''
      opt.time.ddl = t
  if raw.time.duration_limit?
    t = raw.time.duration_limit.trim()
    if t != ''
      opt.time.duration_limit = t
  if raw.time.auto_ready?
    t = raw.time.auto_ready.trim()
    if t != ''
      opt.time.auto_ready = t
  if raw.time.interval?
    t = raw.time.interval.trim()
    if t != ''
      opt.time.interval = t
  if raw.time_base?
    t = raw.time_base.trim()
    if t != ''
      opt.time_base = t
  {
    type
    title
    desc
  } = raw
  one_task.create_task task_id, type, title, desc, opt

create_task = (data) ->
  (dispatch, getState) ->
    dispatch {
      type: T_CREATE_TASK
      payload: data
    }
    $$td = getState().td
    task_id = $$td.get 'next_task_id'

    to = _make_task_data task_id, data
    await td.create_task to
    # create task-create history
    to = one_history.create_history task_id, one_history.TYPE_CREATE
    await td.create_history to
    # NOTE task in enabled by default
    # update data (load) after create task
    await dispatch load_one_task(task_id)
    await dispatch a_td.load_task_list()
    await dispatch a_td.load_next_task_id()

update_task = (data) ->
  (dispatch, getState) ->
    dispatch {
      type: T_UPDATE_TASK
      payload: data
    }
    $$main = getState().main
    task_id = $$main.get 'task_id'

    to = _make_task_data task_id, data
    await td.update_task to
    # update data
    await dispatch a_td.load_task(task_id)

disable_task = (task_id) ->
  (dispatch, getState) ->
    dispatch {
      type: T_DISABLE_TASK
      payload: {
        task_id
      }
    }

    time = new Date().toISOString()
    await td.disable_task task_id, time
    # update task list
    await dispatch a_td.load_task_list()
    await dispatch a_td.load_disabled_list()
    dispatch a_td.calc_task(task_id)

enable_task = (task_id) ->
  (dispatch, getState) ->
    dispatch {
      type: T_ENABLE_TASK
      payload: {
        task_id
      }
    }

    await td.enable_task task_id
    # update task list
    await dispatch a_td.load_task_list()
    await dispatch a_td.load_disabled_list()
    # load task and history
    await dispatch load_one_task(task_id)

change_status = (task_id, status) ->
  (dispatch, getState) ->
    dispatch {
      type: T_CHANGE_STATUS
      payload: {
        task_id
        status
      }
    }
    # TODO check old status is same ?

    h = one_history.create_history task_id, one_history.TYPE_STATUS, status
    await td.create_history h
    # update data
    await dispatch a_td.load_history_list(task_id)
    # load the new history item
    await dispatch a_td.load_history(task_id, h._time)

add_comment = (task_id, text) ->
  (dispatch, getState) ->
    dispatch {
      type: T_ADD_COMMENT
      payload: {
        task_id
        text
      }
    }

    h = one_history.create_history task_id, one_history.TYPE_NOTE, null, text
    await td.create_history h
    # update data
    await dispatch a_td.load_history_list(task_id)
    await dispatch a_td.load_history(task_id, h._time)

hide_history = (task_id, history_name) ->
  (dispatch, getState) ->
    dispatch {
      type: T_HIDE_HISTORY
      payload: {
        task_id
        history_name
      }
    }

    await td.hide_history task_id, history_name
    # update data
    await dispatch a_td.load_history_list(task_id)

show_history = (task_id, history_name) ->
  (dispatch, getState) ->
    dispatch {
      type: T_SHOW_HISTORY
      payload: {
        task_id
        history_name
      }
    }

    await td.show_history task_id, history_name
    # update data
    await dispatch a_td.load_history_list(task_id)

module.exports = {
  T_INIT_LOAD
  T_LOAD_ONE_TASK

  T_CREATE_TASK
  T_UPDATE_TASK
  T_DISABLE_TASK
  T_ENABLE_TASK
  T_CHANGE_STATUS
  T_ADD_COMMENT
  T_HIDE_HISTORY
  T_SHOW_HISTORY

  init_load  # thunk
  load_one_task  # thunk

  create_task  # thunk
  update_task  # thunk
  disable_task  # thunk
  enable_task  # thunk
  change_status  # thunk
  add_comment  # thunk
  hide_history  # thunk
  show_history  # thunk
}
