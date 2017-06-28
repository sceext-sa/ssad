# state.coffee, ssad/ssad_app/ssad_te/src/redux/

init_state = {  # with Immutable
  # navigation part
  nav: {
    # FIXME
    #current: 'root'
    #path: [ 'root' ]
    current: 'page_main'
    path: ['root', 'page_main']
  }
  # main pages
  main: {
    # TODO
  }
}

module.exports = init_state
