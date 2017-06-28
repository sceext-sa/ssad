# tree.coffee, ssad/ssad_app/ssad_te/src/redux/nav/

PAGE_LIST = [
  'page_main'
    'page_file'
      'page_file_select'
    'page_editor'
      'page_editor_mode'
      'page_editor_theme'
      'page_editor_font_size'
      'page_editor_advanced'
    'page_edit'
    'page_config'
      'page_config_id_key'
      'page_config_core'
    'page_about'
  'page_count'
]

get_pos = ($$state) ->
  path = $$state.get('path').toJS()
  current = $$state.get 'current'

  o = {}
  for i in PAGE_LIST
    if i == current
      o[i] = 'current'
    else if path.indexOf(i) != -1
      o[i] = 'left'
    else
      o[i] = 'right'
  o

module.exports = {
  PAGE_LIST

  get_pos
}
