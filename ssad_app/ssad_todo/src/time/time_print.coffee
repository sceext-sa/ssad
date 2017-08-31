# time_print.coffee, ssad/ssad_app/ssad_todo/src/time/

time_parse = require './time_parse'

# TODO support other time-zone ?
_TIME_UTC_8 = 8 * 3600 * 1e3  # offset ms, 8 hour from UTC

_WEEK = '周'
_WEEK_STR = {
  0: '日'
  1: '一'
  2: '二'
  3: '三'
  4: '四'
  5: '五'
  6: '六'
}

_zero_len = (n, l) ->
  o = "#{n}"
  while o.length < l
    o = '0' + o
  o

_print_hour_minute = (hour, minute) ->
  # hour is optional, minute is required
  o = ':' + _zero_len(minute, 2)
  if hour?
    o = _zero_len(hour, 2) + o
  o

_print_month_day = (month, day) ->
  # month is optional, day is required
  o = '-' + _zero_len(day, 2)
  if month?
    o = _zero_len(month, 2) + o
  o

_print_day_in_week = (n) ->
  _WEEK + _WEEK_STR[n]

_offset_date = (raw) ->
  o = new Date raw
  # TODO support other time-zone ?
  t = o.getTime() + _TIME_UTC_8
  o.setTime t
  o

_r_offset_date = (raw) ->
  o = new Date raw
  # TODO support other time-zone ?
  t = o.getTime() - _TIME_UTC_8
  o.setTime t
  o


# TODO support print without second ?
_print_iso_time = (d) ->
  date = _print_iso_date d
  h = d.getUTCHours()
  m = d.getUTCMinutes()
  s = d.getUTCSeconds()
  hour = _zero_len h, 2
  minute = _zero_len m, 2
  second = _zero_len s, 2
  "#{date} #{hour}:#{minute}:#{second}"

_print_iso_date = (date) ->
  y = date.getUTCFullYear()
  m = date.getUTCMonth() + 1
  d = date.getUTCDate()
  w = date.getUTCDay()
  year = _zero_len y, 4
  month = _zero_len m, 2
  day = _zero_len d, 2
  week = _print_day_in_week w
  "#{year}-#{month}-#{day} #{week}"

_print_unit = (data) ->
  if data.unit is 'zero'
    return '0 (zero)'
  "#{data.value} #{time_parse.UNIT_TO_NAME[data.unit]}"


_print_one_time = (data) ->
  switch data.type
    when time_parse.TYPE_ANY_TIME
      'any time'
    when time_parse.TYPE_DAY_IN_WEEK
      _print_day_in_week data.data
    when time_parse.TYPE_ISO_TIME
      _print_iso_time _offset_date(data.data)
    when time_parse.TYPE_ISO_DATE
      _print_iso_date _offset_date(data.data)
    when time_parse.TYPE_MONTH_DAY
      _print_month_day data.month, data.day
    when time_parse.TYPE_HOUR_MINUTE
      _print_hour_minute data.hour, data.minute
    when time_parse.TYPE_UNIT
      _print_unit data
    else
      throw new Error "unknow time type"

print_time = (data) ->
  o = []
  # data is array
  for i in data
    o.push _print_one_time(i)
  o.join ' / '


_get_n_days_ago = (date) ->
  da = _offset_date date
  now = _offset_date new Date()
  nd = new Date now
  nd.setUTCFullYear da.getUTCFullYear()

  nd.setUTCMonth da.getUTCMonth()
  nd.setUTCDate da.getUTCDate()
  # FIX set month/date
  nd.setUTCMonth da.getUTCMonth()
  nd.setUTCDate da.getUTCDate()

  delta_ms = now.getTime() - nd.getTime()

  _o = (x) ->
    Number.parseInt(x / 1e3 / 86400)

  if delta_ms < 0
    o = - _o(- delta_ms)
  else
    o = _o delta_ms
  o

print_iso_date_short = (date, print_days) ->
  n_days_ago = _get_n_days_ago date
  d = _offset_date date
  now = _offset_date new Date()
  # today
  if n_days_ago is 0
    return 'today'
  # yesterday
  if n_days_ago is 1
    return 'yesterday'
  if n_days_ago is -1
    return 'tomorrow'
  # print month-day
  month = _zero_len (d.getUTCMonth() + 1), 2
  day = _zero_len d.getUTCDate(), 2
  o = "#{month}-#{day}"
  # check year is same
  if d.getUTCFullYear() != now.getUTCFullYear()
    year = _zero_len d.getUTCFullYear(), 4
    o = "#{year}-#{o}"
  # add n-days-ago
  DAYS_LIMIT = 32  # TODO change limit ?
  if (n_days_ago < DAYS_LIMIT) and (n_days_ago > - DAYS_LIMIT) and print_days
    if n_days_ago < 0
      o = "#{o} (#{- n_days_ago} days later)"
    else
      o = "#{o} (#{n_days_ago} days ago)"
  # add week
  week = _print_day_in_week d.getUTCDay()
  "#{o} #{week}"

print_iso_time_short = (date, print_days_ago, print_second) ->
  n_days_ago = _get_n_days_ago date
  d = _offset_date date
  now = _offset_date new Date()
  o = ''
  # not today, print date first
  if n_days_ago != 0
    o = print_iso_date_short(date, print_days_ago) + ' '
  # just print time
  hour = _zero_len d.getUTCHours(), 2
  minute = _zero_len d.getUTCMinutes(), 2
  # TODO support n_minutes_ago ?
  o = "#{o}#{hour}:#{minute}"
  # check second
  if print_second
    second = _zero_len d.getUTCSeconds(), 2
    o = "#{o}:#{second}"
  o


module.exports = {
  print_time
  print_iso_date_short
  print_iso_time_short

  offset_date: _offset_date
  r_offset_date: _r_offset_date
}
