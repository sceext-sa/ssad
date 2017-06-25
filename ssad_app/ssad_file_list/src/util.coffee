# util.coffee, ssad/ssad_app/ssad_file_list/src/
#
# use global:
#   window


# html5 API: window.postMessage()
post_msg = (data) ->
  window.parent.postMessage data, '/'


module.exports = {
  post_msg
}
