# file_item.coffee, ssad/ssad_app/ssad_file_list/src/sub/
# css class: sub_file_item

{ createElement: cE } = require 'react'
cC = require 'create-react-class'


FileItem = cC {
  displayName: 'FileItem'

  _on_click: ->
    # check type
    switch @props.type
      when 'dir'
        @props.on_load_dir?(@props.id)
      when 'file'
        @props.on_select_file(@props.id)
      # else: ignore click

  _render_size: ->
    if @props.size?
      (cE 'span', {
        className: 'size'
        },
        # TODO improve style
        @props.size.toString()
      )

  _render_name: ->
    text = @props.name
    if 'dir' == @props.type
      text += '/'

    (cE 'span', {
      className: 'name'
      },
      text
    )

  render: ->
    (cE 'li', {
      # item type: 'dir', 'file', 'unknow'
      className: "sub_file_item #{@props.type}"
      onClick: @_on_click
      },
      (cE 'div', null,
        @_render_name()
        @_render_size()
      )
    )
}

module.exports = FileItem
