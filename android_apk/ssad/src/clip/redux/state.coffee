# state.coffee, ssad/android_apk/ssad/src/clip/redux/

init_state = {  # with Immutable
  clip_list: {
    edit_mode: false
    data: [
      # clip item
      #  {
      #    text: ''
      #    time: ''
      #    selected: false
      #  }
    ]
    index: -1  # current index
    refresh: false  # doing refresh
    # raw data (used to set_clip)
    raw_data: null
  }
}

module.exports = init_state
