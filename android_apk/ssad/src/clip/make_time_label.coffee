# make_time_label.coffee, ssad/android_apk/ssad/src/clip/


# support local time display
_offset_split_time = (time) ->
  d = new Date(time)
  offset = d.getTimezoneOffset() * ( - 60 * 1e3)
  d = new Date(d.getTime() + offset)
  time = d.toISOString()

  o = {}
  # -> 2017
  o.year = time.split('-')[0]
  # -> 06-23
  o.date = time.split('T')[0].split('-')[1..].join('-')
  # -> 02:13
  o.time = time.split('T')[1].split(':')[0...2].join(':')
  o

make_time_label = (time) ->
  d = _offset_split_time time
  now = _offset_split_time(new Date().toISOString())
  # check year
  if d.year != now.year
    return d.year
  # check month / day
  if d.date != now.date
    return d.date
  d.time

module.exports = make_time_label
