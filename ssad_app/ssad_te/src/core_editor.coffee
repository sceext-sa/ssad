# core_editor.coffee, ssad/ssad_app/ssad_te/

config = require './config'
codemirror = require './core/core_codemirror'
ace = require './core/core_ace'


CODEMIRROR = 'codemirror'
ACE = 'ace'

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

module.exports = {
  CODEMIRROR
  ACE

  get_core
  get_editor
}
