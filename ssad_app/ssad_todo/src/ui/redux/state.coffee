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

    # enable_task_list
    show_list: 'current'  # 'current', 'err', 'ok'

    # current task
    task_id: null
    # is create task (or false: edit task)
    is_create_task: false
    # create/edit task
    edit_task: {
      # common task attr
      type: 'oneshot'  # 'regular', 'oneshot'
      #_time  # TODO
      title: ''
      desc: ''
      # oneshot task attr
      time: {
        planned_start: ''  # optional
        ddl: ''  # optional
        duration_limit: ''  # optional
        # regular task attr
        interval: ''  # (required)
      }
      time_base: 'last'  #  'last', 'fixed' (first)
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
  }
  # td: loaded td data (cache)
  td: {
    next_task_id: null  # _NEXT_TASK_ID
    task_list: [        # _TASK_LIST  enabled task list
      # TASK_ID
    ]
    disabled_list: [    # _DISABLED_LIST  disabled task list
      # ISO_TIME..TASK_ID
    ]

    # task info
    task: {
      # TASK_ID: {    # one task item
      #   raw: {}     # `.task.json`  task storage (file) data
      #   history: {  # history data
      #     HISTORY_NAME: {  # one history item  (_time)
      #       # raw: `.task_history.json`  history storage data
      #     }
      #   }
      #   history_list: {  # _HISTORY_LIST
      #     # name: HIDE
      #   }
      #   # calc attr of one task
      #   status: ''  # task current status
      #   text: ''  # task latest text (note or desc)
      #   last_time: ''  # TODO last update time, used for sort tasks (task list)
      # }
    }
  }
}

module.exports = init_state
