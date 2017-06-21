# page_setting.coffee, ssad/android_apk/ssad/src/redux/

{ connect } = require 'react-redux'

PageSetting = require '../page/setting'
action = require './action/page_setting'


_is_config_new: ($$state) ->
  $$old = $$state.get 'config'
  $$new = $$state.get 'new_config'
  # translate port
  $$old = $$old.set $$old.get('port').toString()
  ($$old.is $$new)

mapStateToProps = (state, props) ->
  $$state = state.page_setting
  $$new = $$state.get 'new_config'
  # check root_key
  root_key = $$new.get 'root_key'
  if ! root_key?
    root_key = '(null)'
  {
    port: $$new.get 'port'
    root_key
    root_app: $$new.get 'root_app'

    show_save_button: _is_config_new($$state)
  }

mapDispatchToProps = (dispatch, props) ->
  {
    # pass navigation
    navigation: props.navigation

    on_change_port: (text) ->
      dispatch action.change_port(text)
    on_change_root_app: (text) ->
      dispatch action.change_root_app(text)

    on_make_root_key: ->
      dispatch action.make_root_key()
    on_save: ->
      dispatch action.save()
    on_reset: ->
      dispatch action.reset()
  }

O = connect(mapStateToProps, mapDispatchToProps)(PageSetting)
module.exports = O
