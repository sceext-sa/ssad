# test_time_parse.coffee, ssad/ssad_app/ssad_todo/src/time/

time_parse = require './time_parse'

TEST_DATA = [
  ''
  '*'  # any_time
  '233'
  '0'  # day_in_week
  '6'  # day in week
  '2017-08-19T22:49:12.123Z'  # iso_time
  '2017-08-19T'  # iso_date
  '08-17'  # month_day
  '-17'  # month_day
  '01:23'  # hour_minute
  ':23'  # hour_minute
  '0qq'  # unit: zero
  '1s'  # unit: s
  '2min'  # unit: min
  '3h'  # unit: h
  '4d'  # unit: d
  '5w'  # unit: w
  '6m'  # unit: m
  '7y'  # unit: y

  'TODO'
]


_test_one = (str) ->
  console.log "DEBUG: test -> #{str}"
  try
    result = time_parse.parse_time_str str
    console.log "DEBUG: result #{JSON.stringify result, '    ', '    '}"
  catch e
    console.log "ERROR: throw #{e}  #{e.stack}"


test = ->
  for i in TEST_DATA
    _test_one i
  console.log "[ OK ] test done. "

# start test
test()
