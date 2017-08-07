# task_status.coffee, ssad/ssad_app/ssad_todo/src/td/

# start status
INIT = 'init'

# middle status
WAIT = 'wait'
DOING = 'doing'
PAUSED = 'paused'

# end status
DONE = 'done'
FAIL = 'fail'
CANCEL = 'cancel'

ALL = [
  INIT
  WAIT
  DOING
  PAUSED
  DONE
  FAIL
  CANCEL
]
M = [
  WAIT
  DOING
  PAUSED
]
END = [
  DONE
  FAIL
  CANCEL
]

module.exports = {
  INIT

  WAIT
  DOING
  PAUSED

  DONE
  FAIL
  CANCEL

  ALL
  M
  END
}
