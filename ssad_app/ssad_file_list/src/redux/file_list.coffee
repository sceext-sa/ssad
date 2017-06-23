# file_list.coffee, ssad/ssad_app/ssad_file_list/src/redux/
#
# use global:
#   ReactRedux

{ connect } = ReactRedux

FileList = require '../file_list'
action = require './action'


mapStateToProps = ($$state, props) ->
  {
    # TODO
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # TODO
  }

O = connect(mapStateToProps, mapDispatchToProps)(FileList)
module.exports = O
