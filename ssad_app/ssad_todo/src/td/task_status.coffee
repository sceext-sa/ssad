# task_status.coffee, ssad/ssad_app/ssad_todo/src/td/

# start (before) status
INIT = 'init'
WAIT = 'wait'

# middle status
DOING = 'doing'
PAUSED = 'paused'

# end status
DONE = 'done'
FAIL = 'fail'
CANCEL = 'cancel'

# fake status
READY = 'ready'

ALL = [
  INIT
  WAIT
  DOING
  PAUSED
  DONE
  FAIL
  CANCEL
]


CLASS_BEFORE = [
  INIT
  WAIT
]
CLASS_M = [
  DOING
  PAUSED
]
CLASS_END = [
  DONE
  FAIL
  CANCEL
]


# second status

SECOND_IN = 'in'
SECOND_OUT = 'out'

CLASS_SECOND = [
  SECOND_IN
  SECOND_OUT
]


module.exports = {
  INIT
  WAIT

  DOING
  PAUSED

  DONE
  FAIL
  CANCEL

  READY
  ALL

  CLASS_BEFORE
  CLASS_M
  CLASS_END

  SECOND_IN
  SECOND_OUT

  CLASS_SECOND
}
