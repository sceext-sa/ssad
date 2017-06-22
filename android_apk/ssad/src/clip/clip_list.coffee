# clip_list.coffee, ssad/android_apk/ssad/src/clip/

{
  createClass: cC
  createElement: cE
} = require 'react'
{
  View
  Text
  FlatList
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

NavHeader = require '../sub/nav_header'
ClipItem = require './clip_item'

btn = require '../sub/btn'

PlaceHolder = cC {
  render: ->
    (cE View, {
      style: {
        flex: 1
        justifyContent: 'center'
        alignItems: 'center'
        # TODO
        minHeight: 128
      } },
      (cE Text, {
        style: {
          color: co.text_sec
        } },
        'No item'
      )
    )
}

ClipList = cC {
  render: ->
    right_button = 'Edit'
    click_right = @props.on_enter_edit_mode
    if @props.edit_mode
      right_button = 'Cancel'
      click_right = @props.on_exit_edit_mode
    _render_item = @_render_item

    (cE View, {
      style: [ ss.box, {
        flex: 1
      } ]
      },
      (cE NavHeader, {
        title: 'SSAD clip'
        right: right_button
        on_click_right: click_right
        no_left: true
        })
      (cE View, {
        style: {
          flex: 1
        } },
        # main list
        (cE FlatList, {
          data: @props.list_data
          renderItem: _render_item
          ListEmptyComponent: PlaceHolder
          onRefresh: @props.on_refresh
          refreshing: @props.refreshing
          })
      )
      @_render_main_button()
    )

  _render_main_button: ->
    if @props.selected_count > 0
      (cE btn.BigDangerButton, {
        text: "Remove #{@props.selected_count} items"
        no_margin: true
        on_click: @props.on_remove
        })

  # render list item
  _render_item: (opt) ->
    props_on_set_clip = @props.on_set_clip
    props_on_select_item = @props.on_select_item
    index = opt.item.key
    _on_click = ->
      props_on_set_clip index
    if @props.edit_mode
      _on_click = ->
        props_on_select_item index

    (cE ClipItem, {
      data: opt.item
      on_click: _on_click
      edit_mode: @props.edit_mode
      })
}

module.exports = ClipList
