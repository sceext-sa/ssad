# async.coffee, ssad/ssad_app/ssad_file_list/src/
#
# use global:
#   $

get_json = (url, query) ->
  new Promise (resolve, reject) ->
    r = $.getJSON url, query
    r.done () ->
      resolve r.responseJSON
    r.fail (jqxhr, status, e) ->
      reject e


module.exports = {
  get_json  # async
}
