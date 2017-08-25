# one_task.coffee, ssad/ssad_app/ssad_todo/src/td/
#
# common task attr
#  {
#    task_id: 1
#    type: 'regular'  # 'oneshot', 'regular'
#    #_time
#    title: ''  # one-line text
#    desc: ''
#
#    time: {
#      planned_start: ''   # optional
#      ddl: ''             # optional
#      duration_limit: ''  # optional
#      auto_ready: ''      # optional
#     }
#  }
#
# oneshot task attr
#  {}
#
# regular task attr
#  {
#    time: {
#      interval: ''
#    }
#    time_base: 'last'  # 'last', 'fixed' (first)
#  }
#

td_json = require './td_json'


TASK_TYPE_R = 'regular'
TASK_TYPE_O = 'oneshot'

_gen_time = ->
  (new Date()).toISOString()


create_task = (task_id, type, title, desc, opt) ->
  data = opt
  data.task_id = task_id
  data.type = type
  data.title = title
  data.desc = desc
  o = td_json.create_json data, _gen_time()
  switch type
    when TASK_TYPE_R
      clean_task_r o
    when TASK_TYPE_O
      clean_task_o o
    else
      throw new Error "unknow task type #{type}"


_clean_task = (dd) ->
  {
    task_id: dd.task_id
    type: dd.type
    title: dd.title
    desc: dd.desc
  }

_clean_time = (t) ->
  o = {}
  if t.planned_start?
    o.planned_start = t.planned_start
  if t.ddl?
    o.ddl = t.ddl
  if t.duration_limit?
    o.duration_limit = t.duration_limit
  if t.auto_ready?
    o.auto_ready = t.auto_ready
  o

clean_task_r = (data) ->
  dd = data.data
  d = Object.assign _clean_task(dd), {
    time_base: dd.time_base
    time: Object.assign _clean_time(dd.time), {
      interval: dd.time.interval
    }
  }
  td_json.create_json d, data._time

clean_task_o = (data) ->
  dd = data.data
  d = Object.assign _clean_task(dd), {
    time: _clean_time(dd.time)
  }
  td_json.create_json d, data._time


module.exports = {
  TASK_TYPE_R
  TASK_TYPE_O

  create_task

  clean_task_r
  clean_task_o
}
