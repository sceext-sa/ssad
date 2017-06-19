# color.coffee, ssad/android_apk/ssad/src/style/


# button touch highlight
BACKGROUND_BUTTON_TOUCH = '#dddddd'
# navigation style
BACKGROUND_NAVIGATION = '#101010'
# normal button
BACKGROUND_BUTTON = '#333333'
# second background (area)
BACKGROUND_SECOND = '#212121'
# default background color
BACKGROUND = '#030303'
# text inpu
BACKGROUND_INPUT = '#000000'

# primary button
BACKGROUND_BUTTON_PRIMARY = '#303088'
# danger button
BACKGROUND_BUTTON_DANGER = '#993030'


TEXT_BUTTON = '#efefef'
TEXT_INPUT = '#efefef'
# title (text) color
TITLE = '#aaaaaa'
# default text color (foreground)
TEXT = '#e0e0e0'
# second text (not important)
TEXT_SECOND = '#555555'
# disabled button
TEXT_BUTTON_DISABLED = '#151515'
TEXT_BUTTON_DANGER = '#ffffff'


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
