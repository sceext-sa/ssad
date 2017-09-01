# td_tree.coffee, ssad/ssad_app/ssad_todo/src/td/
#
#   + td/
#     + task/
#       + disabled/
#         - ISO_TIME..TASK_ID.task.json
#       - TASK_ID.task.json
#       - XXXX.max_task_id
#     + history/
#       + TASK_ID/
#         - ISO_TIME..task_history.json
#         - ISO_TIME..hide
#     + back/
#       + TASK_ID/
#         - ISO_TIME..task.json
#     - XXXX.uuid_namespace
#
#  FIX bug: ISO_TIME: replace char ':' -> '_' for filename
#

DIR_ROOT = 'td'
DIR_TASK = 'task'
DIR_DISABLED = 'disabled'
DIR_HISTORY = 'history'
DIR_BACK = 'back'

SUFFIX_TASK = '.task.json'
SUFFIX_HISTORY = '.task_history.json'
SUFFIX_HISTORY_HIDE = '.hide'
SUFFIX_MAX_TASK_ID = '.max_task_id'
SUFFIX_UUID_NAMESPACE = '.uuid_namespace'

DEFAULT_TASK_ID = 1  # task_id starts with 1

module.exports = {
  DIR_ROOT
  DIR_TASK
  DIR_DISABLED
  DIR_HISTORY
  DIR_BACK

  SUFFIX_TASK
  SUFFIX_HISTORY
  SUFFIX_HISTORY_HIDE
  SUFFIX_MAX_TASK_ID
  SUFFIX_UUID_NAMESPACE

  DEFAULT_TASK_ID
}
