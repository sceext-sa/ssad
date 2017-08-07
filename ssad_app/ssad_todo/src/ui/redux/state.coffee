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

    # TODO
  }
  # td data / cache
  task_info: {}
  #{
  #  TASK_ID: {  # one task info
  #    # task data
  #    history: [
  #      {  # one history item
  #        # history data
  #      }
  #    ]
  #  }
  #}
}

module.exports = init_state
