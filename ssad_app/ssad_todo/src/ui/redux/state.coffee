# state.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/

# TODO for ssad_todo: calc with Immutable ?  (use .toJS() as less as possible)


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
    now: null  # TODO update this value every 1 minute ?
    # TODO time-zone config ?

    # enable_task_list
    show_list: 'current'  # 'before', 'current', 'err', 'ok'
    # p_one_task
    show_detail: false
    ot: {  # for show/hide history
      task_id: null  # current task_id, used for update history
      history: {}  # history hide_show status, HISTORY_NAME: show (default false)
    }
    # change_status
    cs: {
      task_id: null  # working task_id
      status: null  # current selected status
      disabled: false  # enable/disable task
      comment: ''  # add comment function
    }

    # current task
    task_id: null
    # is create task (or false: edit task)
    is_create_task: false
    # create/edit task
    edit_task: {
      task_id: null
      # common task attr
      type: 'oneshot'  # 'regular', 'oneshot'
      title: ''
      desc: ''
      # oneshot task attr
      time: {
        planned_start: ''   # optional
        ddl: ''             # optional
        duration_limit: ''  # optional
        auto_ready: ''      # optional
        # regular task attr
        interval: ''  # (required)
      }
      time_base: 'last'  #  'last', 'fixed' (first)
    }

    # load tasks progress
    init_load_progress: {
      now: 0
      all: 0
      done: true  # load done  # Note: true for welcome page
      # TODO support multi-thread load ?
      task_id: null  # loading task_id, for DEBUG
    }
    # flag: doing operation
    op_doing: false
    # TODO show error ?
  }
  # td: loaded td data (cache)
  td: {
    no_calc: true  # flag: not calc_task on task update (to speed up init_load)

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
      #
      #   # calc attr
      #   calc: {
      #     disabled: false  # is task disabled
      #     status: ''  # task current status, include 'ready', 'disabled'
      #     text: ''  # task latest text (note or desc)
      #     last_time: ''  # last update time, use for sort tasks
      #
      #     first_status: null  # first status, not include 'ready' or 'disabled'
      #     second_status: ''  # second status, 'in' or 'out'
      #     last_end: ''  # last end status (iso_time 'str')
      #
      #     planned_start: null  # calc planned_start (iso_time 'str')
      #     ddl: null  # calc ddl (iso_time 'str')
      #     is_ready: false  # flag: for auto_ready
      #   }
      # }
    }
  }
}

module.exports = init_state
