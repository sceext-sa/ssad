# state.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/

init_state = {  # with Immutable
  # navigation
  nav: {
    current: 'root'
    stack: []
  }
  # main pages
  main: {
    # app_id / ssad_key
    ssad: {
      id: null
      key: null
    }
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

    # TODO
  }
  # TODO td data cache ?
}

module.exports = init_state
