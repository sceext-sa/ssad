# tree.coffee, ssad/ssad_app/ssad_todo/src/ui/redux/nav/

PAGE_LIST = [
  'page_welcome'
  'page_enable_task_list'
    'page_one_task'
      'page_change_status'
    'page_edit_create_task'
  'page_main_menu'
    'page_disabled_list'
    'page_about'
    'page_config'
]

get_pos = ($$state) ->
  stack = $$state.get('stack').toJS()
  current = $$state.get 'current'

  o = {}
  for i in PAGE_LIST
    if i == current
      o[i] = 'current'
    else if stack.indexOf(i) != -1
      o[i] = 'left'
    else
      o[i] = 'right'
  o

module.exports = {
  PAGE_LIST

  get_pos
}
