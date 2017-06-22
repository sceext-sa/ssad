# clip_item.coffee, ssad/android_apk/ssad/src/clip/

{
  createClass: cC
  createElement: cE
} = require 'react'
{
  StyleSheet
  View
  Text
  TouchableNativeFeedback
} = require 'react-native'

ss = require '../style/ss'
co = require '../style/color'

s = StyleSheet.create {
  # container
  box_base: {
    flexDirection: 'row'
    alignItems: 'center'
    padding: 0
    paddingTop: 10
    paddingBottom: 10
    borderWidth: 0
    borderBottomWidth: 1
    borderColor: co.bg_sec
  }
  left_box: {
    justifyContent: 'center'
    alignItems: 'center'
    width: 28
    paddingRight: 2
    alignSelf: 'start'
  }
  right_box: {
    justifyContent: 'center'
    alignItems: 'center'
    width: 34
    paddingRight: 4
    alignSelf: 'end'
  }

  box: {
    backgroundColor: co.bg_box
  }
  # (not edit-mode) current clip content
  box_current: {
    backgroundColor: co.bg_sec
  }
  # edit mode
  box_selected: {
    backgroundColor: co.bg_sec
  }

  # left part
  left_base: {
    textAlign: 'center'
  }
  left: {
    color: co.bg_box
    backgroundColor: co.text_sec
    paddingTop: 1
    width: 16
    height: 16
    borderRadius: 8
    fontSize: 9
  }
  # current clip content
  left_current: {
    color: co.bg_btn_p
    fontSize: 20
  }
  # edit mode
  left_selected: {
    color: co.bg_btn_danger
    fontSize: 64
    fontWeight: 'bold'
  }

  # clip text (content)
  text: {
    flex: 1
    color: co.text
  }
  # right (time) style
  right: {
    color: co.text_sec
    fontSize: 10
    textAlign: 'center'
  }
}


_make_time_label = (time) ->
  d = new Date time
  now = new Date()
  # check year
  if now.getYear() != d.getYear()
    # -> 2017
    return time.split('-')[0]
  # check month / day
  if (now.getMonth() != d.getMonth()) || (now.getDate() != d.getDate())
    # TODO support local time ?
    # -> 06-22
    return time.split('T')[0].split('-')[1..].join('-')
  # TODO support local time ?
  # -> 02:33
  time.split('T')[1].split(':')[0...2].join(':')

ClipItem = cC {
  render: ->
    # available props
    #  @props.on_click
    #  @props.edit_mode
    #  @props.data
    #    {
    #      key: 0  # index of this item
    #      index: N  # current clip index
    #      time: ''
    #      text: ''
    #      selected: false
    #      i: '1'  # show number of this item
    #    }
    left = @props.data.i
    text = @props.data.text
    right = _make_time_label @props.data.time

    box_s = s.box
    left_s = s.left
    # check status
    if @props.data.key == @props.data.index
      # current index is this
      left = '>'
      box_s = s.box_current
      left_s = s.left_current
    if @props.edit_mode && @props.data.selected
      left = 'x'
      box_s = s.box_selected
      left_s = s.left_selected

    (cE TouchableNativeFeedback, {
      onPress: @props.on_click
      background: TouchableNativeFeedback.Ripple co.bg_btn_touch
      },
      (cE View, {
        style: [ s.box_base, box_s ]
        },
        # left part
        (cE View, {
          style: s.left_box
          },
          (cE Text, {
            style: [ s.left_base, left_s ]
            },
            left
          )
        )
        # text part
        (cE Text, {
          style: s.text
          },
          text
        )
        # right (time)
        (cE View, {
          style: s.right_box
          },
          (cE Text, {
            style: s.right
            },
            right
          )
        )
      )
    )
}

module.exports = ClipItem
