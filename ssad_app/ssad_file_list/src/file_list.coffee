# file_list.coffee, ssad/ssad_app/ssad_file_list/src/
# css class: file_list

{ createElement: cE } = require 'react'
cC = require 'create-react-class'

FileItem = require './sub/file_item'
InputKey = require './sub/input_key'


FileList = cC {
  displayName: 'FileList'

  _render_list: ->
    o = []
    for i in @props.list
      o.push (cE FileItem, {
        key: i.name
        id: i.name
        name: i.name
        type: i.type
        size: i.size
        on_load_dir: @props.on_load_dir
        on_select_file: @props.on_select_file
        })
    o

  _render_input_key: ->
    if @props.show_input_key
      (cE InputKey, {
        input: @props.input
        error: @props.error
        on_change_id: @props.on_change_id
        on_change_key: @props.on_change_key
        on_save_config: @props.on_save_config
        })

  render: ->
    (cE 'div', {
      className: 'file_list'
      },
      (cE 'ul', null,
        @_render_list()
      )
      @_render_input_key()
    )
}

module.exports = FileList
