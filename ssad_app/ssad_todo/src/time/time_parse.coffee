# time_parse.coffee, ssad/ssad_app/ssad_todo/src/time/
#
# ssad_todo time type:
#
#   + 'any_time': '*'
#
#   + 'day_in_week': single number, eg: 0, 1, 2, .. . , 6
#       or single char: '0', '1', .. .
#
#   + 'iso_time': full ISO time, eg: '2017-08-19T01:23:45.678Z'
#       TODO other str can be parse by `new Date()` ?
#
#   + 'iso_date': only date (year-month-day), eg: '2017-08-19T'
#
#   + 'month_day': only month-day, eg: '08-17', '-17' (no month)
#
#   + 'hour_minute': only hour:minute, eg: '01:23', ':23' (no hour)
#
#   + 'unit': time with a unit, used for regular: time.interval
#

TIME_SEP = '/'  # multi-part time str
STR_ANY_TIME = '*'
STR_ISO_TIME_SUFFIX = 'Z'
STR_ISO_DATE_SUFFIX = 'T'
STR_MONTH_DAY = '-'
STR_HOUR_MINUTE = ':'

TYPE_ANY_TIME = 'any_time'
TYPE_DAY_IN_WEEK = 'day_in_week'
TYPE_ISO_TIME = 'iso_time'
TYPE_ISO_DATE = 'iso_date'
TYPE_MONTH_DAY = 'month_day'
TYPE_HOUR_MINUTE = 'hour_minute'
TYPE_UNIT = 'unit'

# supported time units
UNIT_TO_NAME = {
  's': 'second'  # TODO reserved now
  'min': 'minute'  # TODO reserved now
  'h': 'hour'
  'd': 'day'
  'w': 'week'
  'm': 'month'  # TODO reserved now
  'y': 'year'  # TODO reserved now

  'zero': 'no unit'  # unit for zero value
}

DAY_IN_WEEK_MIN = 0
DAY_IN_WEEK_MAX = 6

DAY_IN_MONTH = {
  1: 31
  2: 29  # unknow year
  3: 31
  4: 30
  5: 31
  6: 30
  7: 31
  8: 31
  9: 30
  10: 31
  11: 30
  12: 31
}


_trim_throw = (raw, error_text) ->
  o = ("#{raw}").trim()
  if o is ''
    throw new Error "empty #{error_text}: #{raw}"
  o

_char_n = (c, to) ->
  count = 0
  for i in [0... to.length]
    if to[i] is c
      count += 1
  count

_parse_int = (raw) ->
  o = Number.parseInt raw
  if Number.isNaN o
    throw new Error "bad number str: #{raw}"
  o


# iso_time / iso_date
_parse_iso_time = (raw) ->
  o = new Date raw
  if Number.isNaN o.getTime()
    throw new Error "bad iso_time: #{raw}"
  o

_parse_month_day = (raw) ->
  o = {
    type: TYPE_MONTH_DAY
    month: null  # optional
    day: null  # required
  }
  p = raw.split STR_MONTH_DAY
  o.day = _parse_int p[1]
  if (o.day < 1) or (o.day > 31)
    throw new Error "bad day: #{raw}"
  if p[0].trim() != ''
    o.month = _parse_int p[0]
    if (o.month < 1) or (o.month > 12)
      throw new Error "bad month: #{raw}"
  # check day based on month
  if o.month? and (o.day > DAY_IN_MONTH[o.month])
    throw new Error "bad day: #{raw}"
  o

_parse_hour_minute = (raw) ->
  o = {
    type: TYPE_HOUR_MINUTE
    hour: null  # optional
    minute: null  # required
  }
  p = raw.split STR_HOUR_MINUTE
  o.minute = _parse_int p[1]
  if (o.minute < 0) or (o.minute > 59)
    throw new Error "bad minute: #{raw}"
  if p[0].trim() != ''
    o.hour = _parse_int p[0]
    if (o.hour < 0) or (o.hour > 24)
      throw new Error "bad hour: #{raw}"
    # check '24:00'
    if (o.hour is 24) and (o.minute != 0)
      throw new Error "bad hour: #{raw}"
  o

_parse_unit = (raw) ->
  o = {
    type: TYPE_UNIT
    unit: null
    value: _parse_int raw
  }
  # check zero value
  if o.value is 0
    o.unit = 'zero'
    return o
  if o.value < 0
    throw new Error "bad value: #{raw}"
  # try each unit
  for u in Object.keys(UNIT_TO_NAME)
    if raw.endsWith u
      o.unit = u
      return o
  throw new Error "unknow unit: #{raw}"

_parse_one_part = (raw) ->
  raw = _trim_throw raw, 'part'
  # check type

  # any_time
  if raw is STR_ANY_TIME
    return {
      type: TYPE_ANY_TIME
    }
  # day_in_week
  if raw.length is 1
    d = _parse_int raw
    if (d < DAY_IN_WEEK_MIN) or (d > DAY_IN_WEEK_MAX)
      throw new Error "bad day_in_week: #{raw}"
    return {
      type: TYPE_DAY_IN_WEEK
      data: d
    }
  # iso_time
  if raw.endsWith STR_ISO_TIME_SUFFIX
    return {
      type: TYPE_ISO_TIME
      data: _parse_iso_time raw
    }
  # iso_date
  if raw.endsWith STR_ISO_DATE_SUFFIX
    return {
      type: TYPE_ISO_DATE
      data: _parse_iso_time raw[0... (raw.length - 1)]
    }
  # month_day
  if _char_n(STR_MONTH_DAY, raw) is 1
    return _parse_month_day raw
  # hour_minute
  if _char_n(STR_HOUR_MINUTE, raw) is 1
    return _parse_hour_minute raw
  # try unit
  try
    return _parse_unit raw
  catch e
    # ignore error
  # try other format parsed by `new Date()`
  try
    d = _parse_iso_time raw
  catch e
    throw new Error "unknow time type: #{raw}"
  {
    type: TYPE_ISO_TIME
    data: d
  }

parse_time_str = (raw) ->
  raw = _trim_throw raw, 'time_str'
  # process multi-part
  part = raw.split TIME_SEP
  o = []
  for p in part
    o.push _parse_one_part(p)
  o

module.exports = {
  TIME_SEP
  STR_ANY_TIME

  TYPE_ANY_TIME
  TYPE_DAY_IN_WEEK
  TYPE_ISO_TIME
  TYPE_ISO_DATE
  TYPE_MONTH_DAY
  TYPE_HOUR_MINUTE
  TYPE_UNIT

  UNIT_TO_NAME

  parse_time_str
}
