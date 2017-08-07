# one_history.coffee, ssad/ssad_app/ssad_todo/src/td/
#
# task_history attr
#  {
#    task_id: 1
#    type: 'status'  # 'status', 'note', 'create'
#    #_time
#    status: ''  # optional
#    note: ''  # optional
#  }
#

td_json = require './td_json'

TYPE_STATUS = 'status'
TYPE_NOTE = 'note'
TYPE_CREATE = 'create'
TYPE_ALL = [
  TYPE_STATUS
  TYPE_NOTE
  TYPE_CREATE
]

_gen_time = ->
  (new Date()).toISOString()



create_history = (task_id, type, status, note) ->
  data = {
    task_id
    type
  }
  if status?
    data.status = status
  if note?
    data.note = note
  # check type
  if TYPE_ALL.indexOf(type) == -1
    throw new Error "unknow task_history type #{type}"
  td_json.create_json data, _gen_time()

module.exports = {
  TYPE_STATUS
  TYPE_NOTE
  TYPE_CREATE
  TYPE_ALL

  create_history
}
