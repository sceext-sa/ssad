# core_editor.coffee, ssad/ssad_app/ssad_te/src/

config = require './config'
a_common = require './redux/action/a_common'
core_codemirror = require './core/core_codemirror'
core_ace = require './core/core_ace'


# core editor names
CORE_EDITOR_CODEMIRROR = 'codemirror'
CORE_EDITOR_ACE = 'ACE'

# global data
_etc = {
  current_core_name: null

  # core single instance
  core_cm: null
  core_ace: null
  # core root html element
  root_e_cm: null
  root_e_ace: null

  # for codemirror
  cm_clean_mark: null  # check is_clean
}


# global methods

# set html element for core to init
set_core_root_element = (core_name, el) ->
  switch core_name
    when CORE_EDITOR_CODEMIRROR
      _etc.root_e_cm = el
    when CORE_EDITOR_ACE
      _etc.root_e_ace = el
    else
      throw new Error "no such core #{core_name}"

# set current core, and init it if not
set_core = (core_name) ->
  switch core_name
    when CORE_EDITOR_CODEMIRROR
      if ! _etc.core_cm?
        _init_core_cm()
    when CORE_EDITOR_ACE
      if ! _etc.core_ace?
        _init_core_ace()
    else
      throw new Error "no such core #{core_name}"
  # set current core
  _etc.current_core_name = core_name
  # try copy text from one core to another
  switch core_name
    when CORE_EDITOR_CODEMIRROR
      if _etc.core_ace?
        _etc.core_cm.set_text _etc.core_ace.get_text()
    when CORE_EDITOR_ACE
      if _etc.core_cm?
        _etc.core_ace.set_text _etc.core_cm.get_text()

get_current_core_name = ->
  _etc.current_core_name

# get current core instance
_c = ->
  switch _etc.current_core_name
    when CORE_EDITOR_CODEMIRROR
      _etc.core_cm
    when CORE_EDITOR_ACE
      _etc.core_ace
get_core = ->
  _c()

get_core_version = (core_name) ->
  switch core_name
    when CORE_EDITOR_CODEMIRROR
      core_codemirror.get_version()
    when CORE_EDITOR_ACE
      core_ace.get_version()


# common methods for each core

get_text = ->
  _c().get_text()
set_text = (text) ->
  _c().set_text text
get_line_count = ->
  _c().get_line_count()

mark_clean = ->
  switch _etc.current_core_name
    when CORE_EDITOR_CODEMIRROR
      _etc.cm_clean_mark = _c().get_clean_mark()
    when CORE_EDITOR_ACE
      _c().mark_clean()

is_clean = ->
  switch _etc.current_core_name
    when CORE_EDITOR_CODEMIRROR
      _c().is_clean _etc.cm_clean_mark
    when CORE_EDITOR_ACE
      _c().is_clean()

get_theme_list = ->
  switch _etc.current_core_name
    when CORE_EDITOR_CODEMIRROR
      core_codemirror.get_theme_list()
    when CORE_EDITOR_ACE
      core_ace.get_theme_list()

get_mode_list = ->
  switch _etc.current_core_name
    when CORE_EDITOR_CODEMIRROR
      core_codemirror.get_mode_list()
    when CORE_EDITOR_ACE
      core_ace.get_mode_list()

# TODO support custom theme ?

set_theme = (theme_name) ->
  await _c().set_theme theme_name
set_mode = (mode) ->
  await _c().set_mode mode
set_fontsize = (size) ->
  _c().set_fontsize size
set_show_line_number = (enable) ->
  _c().set_show_line_number enable
set_line_wrap = (enable) ->
  _c().set_line_wrap enable
set_read_only = (enable) ->
  _c().set_read_only enable
set_tab_size = (size) ->
  _c().set_tab_size size

undo = ->
  _c().undo()
redo = ->
  _c().redo()

set_overwrite = (enable) ->
  _c().set_overwrite enable
set_show_invisibles = (enable) ->
  _c().set_show_invisibles enable

# core init

_on_change = (data) ->
  # check is_clean, and dispatch to store
  config.store().dispatch a_common.set_doc_clean(is_clean())

_init_core_cm = ->
  _etc.core_cm = core_codemirror.init_editor _etc.root_e_cm
  # add event listener
  _etc.core_cm.on 'change', _on_change
  # init clean mark
  _etc.cm_clean_mark = _etc.core_cm.get_clean_mark()

_init_core_ace = ->
  _etc.core_ace = core_ace.init_editor _etc.root_e_ace
  # add event listener
  _etc.core_ace.on 'change', _on_change

# methods only for codemirror

cm_get_mode_by_filename = (filename) ->
  core_codemirror.get_mode_by_filename filename
cm_set_placeholder = (text) ->
  _c().set_placeholder text
cm_set_scrollbar_style = (style) ->
  _c().set_scrollbar_style style
cm_get_history_count = ->
  _c().get_history_count()
cm_set_right_ruler = (n) ->
  _c().set_right_ruler n

# methods only for ace
ace_set_scroll_past_end = (enable) ->
  _c().set_scroll_past_end enable
ace_set_cursor_style = (s) ->
  _c().set_cursor_style s
ace_set_h_scrollbar_always_show = (enable) ->
  _c().set_h_scrollbar_always_show enable
ace_set_v_scrollbar_always_show = (enable) ->
  _c().set_v_scrollbar_always_show enable


module.exports = {
  CORE_EDITOR_CODEMIRROR
  CORE_EDITOR_ACE

  set_core_root_element
  set_core
  get_current_core_name
  get_core
  get_core_version

  get_text
  set_text
  get_line_count

  mark_clean
  is_clean

  get_theme_list
  get_mode_list
  set_theme  # async
  set_mode  # async

  set_fontsize
  set_show_line_number
  set_line_wrap
  set_read_only
  set_tab_size

  undo
  redo

  set_overwrite
  set_show_invisibles

  cm_get_mode_by_filename
  cm_set_placeholder
  cm_set_scrollbar_style
  cm_get_history_count
  cm_set_right_ruler

  ace_set_scroll_past_end
  ace_set_cursor_style
  ace_set_h_scrollbar_always_show
  ace_set_v_scrollbar_always_show
}
