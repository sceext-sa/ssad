# core_editor.coffee, ssad/ssad_app/ssad_te/src/

config = require './config'
a_common = require './redux/action/a_common'
codemirror = require './core/core_codemirror'
ace = require './core/core_ace'


CODEMIRROR = 'codemirror'
ACE = 'ace'


_etc = {
  # TODO
  core: null  # current core

  clean_mark: null  # mark used to check is_clean
}


get_core = (name) ->
  switch name
    when CODEMIRROR
      codemirror
    when ACE
      ace
    else
      throw new Error "no such core_editor #{name}"

# only create single instance of core editor
get_editor = (name, e_root) ->
  core = get_core name
  switch name
    when CODEMIRROR
      if ! config.core_codemirror()?
        c = core.init_editor e_root
        config.core_codemirror c
      o = config.core_codemirror()
    when ACE
      if ! config.core_ace()?
        c = core.init_editor e_root
        config.core_ace c
      o = config.core_ace()
  o


_on_change = (change) ->
  # check is_clean, and dispatch to store
  config.store().dispatch a_common.set_doc_clean(is_clean())


# simple init function
init = (e_root) ->
  # TODO support ACE ?
  # default load CodeMirror core
  _etc.core = get_editor CODEMIRROR, e_root
  # set event listener
  _etc.core.on 'change', _on_change
  # init clean mark
  mark_clean()

mark_clean = ->
  # TODO support ACE ?
  _etc.clean_mark = _etc.core.get_clean_mark()

is_clean = ->
  # TODO support ACE ?
  _etc.core.is_clean _etc.clean_mark

get_text = ->
  _etc.core.get_text()

set_text = (text) ->
  _etc.core.set_text text


module.exports = {
  CODEMIRROR
  ACE

  get_core
  get_editor
  init

  mark_clean
  is_clean
  get_text
  set_text
}
