# state.coffee, ssad/ssad_app/ssad_te/src/redux/

init_state = {  # with Immutable
  # navigation part
  nav: {
    current: 'root'
    stack: []
  }
  # main pages
  main: {
    # app_id / ssad_key
    app_id: null
    ssad_key: null
    # file page
    file: {
      # ssad_file_list
      sub_root: null
      sub_path: null
      root_path: null
      path: null
      filename: null
      # TODO error ?
    }
    # content text (document) clean
    doc_clean: true
    # editor page
    editor: {
      mode: null  # TODO
      theme: null  # TODO
      font_size: null  # TODO
      # TODO advanced ?
    }
    # TODO edit part
    edit: {}  # TODO
    # config page
    config: {
      # input
      app_id: 'ssad_te'
      ssad_key: ''
      # app_id/ssad_key error
      error: null
      # core editor type  (TODO ACE)
      core_editor: 'codemirror'  # 'codemirror', 'ace'
    }
    # count page
    count: {
      # TODO
    }
  }
}

module.exports = init_state
