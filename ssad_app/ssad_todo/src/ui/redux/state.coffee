# state.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/

init_state = {  # with Immutable
  # navigation
  nav: {
    current: 'root'
    stack: []
  }
  # main pages
  main: {
    # welcome page
    wel: {
      # input
      app_id: 'ssad_todo'
      ssad_key: ''
      # app_id/ssad_key error
      error: null
    }
    # current time: for global time display/show (update)
    now: null
    # TODO time-zone config ?

    # current task
    task_id: null
    # is create task (or false: edit task)
    is_create_task: false

    # loaded td data (cache)
    task_info: {
      task: {}  # TASK_ID to task data
      # {
      #   TASK_ID: {  # one task info
      #     raw: {}  # `.task.json`  task storage (file) data
      #     history: {  # history data
      #       HISTORY_NAME: {  # one history info  (_time)
      #         raw: {}  # `.task_history.json`  history storage data
      #         hide: false  # history hide flag
      #       }
      #     }
      #     # TODO save full history items list here ?
      #   }
      # }
      enable_list: {}  # enabled task list
      # {
      #   LAST_UPDATE_TIME: TASK_ID
      # }
      disabled_list: {}  # disabled task list
      # {
      #   _TIME: TASK_ID
      # }
      # TODO save full disabled task list here ?
    }
    # load tasks progress
    init_load_progress: {
      now: 0
      all: 0
      done: true  # load done  # NOTE: true for welcome page
    }
    # flag: doing operation
    op_doing: false
    # TODO show error ?

    # TODO
  }
}

module.exports = init_state
