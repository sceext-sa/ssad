# file_list.coffee, ssad/ssad_app/ssad_file_list/src/
#
# use global:
#   React

{ createElement: cE } = React
cC = require 'create-react-class'

FileItem = require './sub/file_item'


FileList = cC {
  render: ->
    # TODO
    (cE 'div', {
      className: 'file_list'
      })
}

module.exports = FileList
