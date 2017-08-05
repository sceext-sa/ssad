# state.coffee, ssad/ssad_app/ssad_te/src/redux/

core_editor = require '../core_editor'

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
    # page_file_auto_save
    auto_save: {
      enable: true  # enable auto_save function
      last_time: null  # last auto_save (check) time
      logs: []  # auto_save log text

      _last_clean_mark: null  # used to avoid un-need saves
    }
    # content text (document) clean
    doc_clean: true
    filename: null  # global show filename (after open)
    # editor page
    editor: {
      # different core use different config
      codemirror: {
        # TODO
        mode: null
        theme: null
        font_size: null

        show_line_number: false
        line_wrap: true
        read_only: false
        tab_size: 4  # TODO
        overwrite: false  # TODO
        show_invisibles: true

        # only for CodeMirror
        cm_scrollbar_style: 'native'  # 'native', 'overlay', 'null', 'simple'
        cm_right_ruler: 80  # TODO
      }
      ACE: {
        # TODO
        mode: null
        theme: null
        font_size: null

        show_line_number: false
        line_wrap: true
        read_only: false
        tab_size: 4  # TODO
        overwrite: false  # TODO
        show_invisibles: true

        # only for ACE
        ace_scroll_past_end: true
        ace_cursor_style: 'ace'  # 'ace', 'slim', 'smooth', 'wide'
        ace_show_scrollbar_h: false  # TODO
        ace_show_scrollbar_v: false  # TODO
      }
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
      # core editor type
      core_editor: core_editor.CORE_EDITOR_CODEMIRROR  # 'codemirror', 'ACE'
    }
    # count page
    count: {
      # count values
      info: {
        chars: 0
        lines: 0
        no_empty_lines: 0
        no_empty_chars: 0
        no_ascii_chars: 0
        # words
        words: 0
        words_ascii: 0
        words_no_ascii: 0
        words_mix: 0
        # more counts
        empty_lines: 0
        empty_chars: 0
        ascii_chars: 0
        'words+no_ascii_chars': 0
        'words_ascii+no_ascii_chars': 0
      }
      # main count to display (on main_top_bar)
      main: 'words+no_ascii_chars'
    }
  }
}

module.exports = init_state
