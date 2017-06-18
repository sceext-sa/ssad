# color.coffee, ssad/android_apk/ssad/src/style/


# default background color
BACKGROUND = '#151c10'
# default text color (foreground)
TEXT = '#aaaaaa'

# title (text) color
TITLE = '#ffffff'
# second text (not important)
TEXT_SECOND = '#888888'
# second background (area)
BACKGROUND_SECOND = '#222222'

# text input
BACKGROUND_INPUT = '#000000'
TEXT_INPUT = '#cccccc'

# normal button
BACKGROUND_BUTTON = '#333333'
TEXT_BUTTON = '#cccccc'
# button touch highlight
BACKGROUND_BUTTON_TOUCH = '#999999'
# disabled button
TEXT_BUTTON_DISABLED = '#777777'

# primary button
BACKGROUND_BUTTON_PRIMARY = '#0000ee'

# danger button
BACKGROUND_BUTTON_DANGER = '#ff0000'
TEXT_BUTTON_DANGER = '#ffffff'

# navigation style
BACKGROUND_NAVIGATION = '#444444'


module.exports = {
  bg: BACKGROUND
  text: TEXT

  bg_nav: BACKGROUND_NAVIGATION

  title: TITLE
  text_sec: TEXT_SECOND
  bg_sec: BACKGROUND_SECOND

  bg_in: BACKGROUND_INPUT
  text_in: TEXT_INPUT

  bg_btn: BACKGROUND_BUTTON
  text_btn: TEXT_BUTTON
  bg_btn_touch: BACKGROUND_BUTTON_TOUCH

  bg_btn_p: BACKGROUND_BUTTON_PRIMARY
  bg_btn_danger: BACKGROUND_BUTTON_DANGER

  text_btn_disabled: TEXT_BUTTON_DISABLED
  text_btn_danger: TEXT_BUTTON_DANGER
}
