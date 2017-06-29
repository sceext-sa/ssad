# core_codemirror.coffee, ssad/ssad_app/ssad_te/
# use global:
#   CodeMirror

EventEmitter = require 'events'


THEME_LIST = [
  # TODO
]

DEFAULT_OPTIONS = {
  mode: null
  theme: 'blackboard'

  lineWrapping: true
  lineNumbers: true

  matchBrackets: true
  highlightSelectionMatches: true
  styleActiveLine: true
  placeholder: '  CodeMirror editor'
  rulers: [ { column: 80 } ]
}

_load_mode = (m) ->
  # TODO
  await return

_load_theme = (theme_name) ->
  # TODO
  await return


class CMCore extends EventEmitter
  constructor: (cm) ->
    super()
    @_cm = cm
    @_init_events()

  # set event listeners
  _init_events: ->
    that = this
    @_cm.on 'changes', (instance, changes) ->
      that._on_changes instance, changes
  # sub event listeners
  _on_changes: (cm, changes) ->
    # TODO

  # public methods
  set_mode: (m) ->  # async
    await _load_mode m
    @_cm.setOption 'mode', m

  set_theme: (theme_name) ->  # async
    await _load_theme theme_name
    @_cm.setOption 'theme', theme_name

  set_fontsize: (size) ->
    # TODO

  set_show_line_number: (enable) ->
    @_cm.setOption 'lineNumbers', enable

  set_line_wrap: (enable) ->
    @_cm.setOption 'lineWrapping', enable

  set_read_only: (enable) ->
    @_cm.setOption 'readOnly', enable

  set_tab_size: (size) ->
    @_cm.setOption 'tabSize', size

  set_placeholder: (text) ->
    @_cm.setOption 'placeholder', text

  # operations
  get_text: ->
    @_cm.getValue()

  set_text: (text) ->
    @_cm.setValue text

  get_line_count: ->
    @_cm.lineCount()

  undo: ->
    @_cm.undo()

  redo: ->
    @_cm.redo()

  get_history_count: ->
    @_cm.distorySize()

  set_overwrite: (enable) ->
    @_cm.toggleOverwrite enable

  get_clean_mark: ->
    @_cm.changeGeneration()

  is_clean: (mark) ->
    @_cm.isClean mark

  set_right_ruler: (n) ->
    @_cm.setOption 'rulers', [
      { column: n }
    ]


init_editor = (e_root) ->
  cm = CodeMirror(e_root, DEFAULT_OPTIONS)
  o = new CMCore cm
  o

get_version = ->
  CodeMirror.version

get_mode_list = ->
  CodeMirror.modeInfo

get_theme_list = ->
  THEME_LIST

get_mode_by_filename = (filename) ->
  CodeMirror.findModeByFilename filename


module.exports = {
  init_editor

  get_version
  get_mode_list
  get_theme_list
  get_mode_by_filename
}
