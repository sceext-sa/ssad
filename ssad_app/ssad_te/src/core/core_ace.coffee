# core_ace.coffee, ssad/ssad_app/ssad_te/src/core/
# use global:
#   ace

EventEmitter = require 'events'


DEFAULT_OPTIONS = {
  highlightActiveLine: true
  highlightSelectedWord: true
  highlightGutterLine: true
  newLineMode: 'unix'  # \n, LF

  theme: 'ace/theme/tomorrow_night_bright'
  mode: 'ace/mode/text'
  showGutter: true
  # showLineNumbers: true
  tabSize: 4
  wrap: true
  # fontSize: ''
  # readOnly: false
  # overwrite: false

  showInvisibles: true
  scrollPastEnd: true

  # cursorStyle: 'ace', 'slim', 'smooth', 'wide'
  # hScrollBarAlwaysVisible: false
  # vScrollBarAlwaysVisible: true

  # fontFamily: ''
  # firstLineNumber: 1
}


class ACEcore extends EventEmitter
  constructor: (a) ->
    super()
    @_ace = a
    # init options
    @_ace.setOptions DEFAULT_OPTIONS
    @_init_events()

  # set event listeners
  _init_events: ->
    that = this
    @_ace.getSession().on 'change', (event) ->
      that._on_change event
  # sub event listeners
  _on_change: (event) ->
    @emit 'change', event

  # public methods
  set_mode: (m) ->
    @_ace.setOption 'mode', m

  set_theme: (theme_path) ->
    @_ace.setOption 'theme', theme_path

  set_fontsize: (size) ->
    @_ace.setOption 'fontSize', size

  set_show_line_number: (enable) ->
    @_ace.setOption 'showGutter', enable

  set_line_wrap: (enable) ->
    @_ace.setOption 'wrap', enable

  set_read_only: (enable) ->
    @_ace.setOption 'readOnly', enable

  set_tab_size: (size) ->
    @_ace.setOption 'tabSize', size

  # operations
  get_text: ->
    @_ace.getValue()

  set_text: (text) ->
    @_ace.setValue text
    # reset undo after load new document
    @reset_undo()

  get_line_count: ->
    @_ace.session.getLength()

  undo: ->
    @_ace.undo()
  redo: ->
    @_ace.redo()

  set_overwrite: (enable) ->
    @_ace.setOption 'overwrite', enable

  # for clean check
  reset_undo: ->
    @_ace.session.getUndoManager().reset()

  mark_clean: ->
    @_ace.session.getUndoManager().markClean()

  is_clean: ->
    @_ace.session.getUndoManager().isClean()

  # TODO check has_undo ?

  # more options for ACE
  set_scroll_past_end: (enable) ->
    @_ace.setOption 'scrollPastEnd', enable

  set_show_invisibles: (enable) ->
    @_ace.setOption 'showInvisibles', enable

  set_cursor_style: (s) ->
    @_ace.setOption 'cursorStyle', s

  set_h_scrollbar_always_show: (enable) ->
    @_ace.setOption 'hScrollBarAlwaysVisible', enable

  set_v_scrollbar_always_show: (enable) ->
    @_ace.setOption 'vScrollBarAlwaysVisible', enable

# TODO support placeholder ?


init_editor = (e_root) ->
  a = ace.edit e_root
  o = new ACEcore a
  o

get_version = ->
  # TODO

get_mode_list = ->
  modelist = ace.require 'ace/ext/modelist'
  # TODO

get_theme_list = ->
  themelist = ace.require 'ace/ext/themelist'
  # TODO

get_mode_by_filename = (filename) ->
  modelist = ace.require 'ace/ext/modelist'
  modelist.getModeForPath(filename).mode

module.exports = {
  init_editor

  get_version
  get_mode_list
  get_theme_list
  get_mode_by_filename
}
