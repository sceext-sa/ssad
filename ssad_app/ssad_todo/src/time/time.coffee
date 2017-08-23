# time.coffee, ssad/ssad_app/ssad_todo/src/time/

time_parse = require './time_parse'
time_print = require './time_print'


module.exports = {
  parse_time_str: time_parse.parse_time_str

  print_time: time_print.print_time
  print_iso_date_short: time_print.print_iso_date_short
  print_iso_time_short: time_print.print_iso_time_short
}
