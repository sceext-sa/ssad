# state.coffee, ssad/ssad_app/ssad_te/src/redux/

init_state = {  # with Immutable
  # navigation part
  nav: {
    # FIXME
    #current: 'root'
    #stack: []
    current: 'page_main'
    stack: ['root']
  }
  # main pages
  main: {
    # TODO
  }
}

module.exports = init_state
