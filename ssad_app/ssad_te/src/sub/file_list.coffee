# file_list.coffee, ssad/ssad_app/ssad_te/src/sub/
# css class: sub_file_list
#
# use global:
#   window

querystring = require 'querystring'

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

ssad_server_api = require '../ssad_server_api'


FileList = cC {
  displayName: 'FileList'
  propTypes: {
    app_id: PropTypes.string.isRequired
    ssad_key: PropTypes.string.isRequired

    on_error: PropTypes.func.isRequired
    on_load_dir: PropTypes.func.isRequired
    on_select_file: PropTypes.func.isRequired
  }

  _decode_msg: (data) ->
    switch data.type
      when 'load_dir'
        @props.on_load_dir data.payload
      when 'select_file'
        @props.on_select_file data.payload
      when 'error'
        @props.on_error data.payload.error  # TODO more info ?
      #else: TODO

  _on_msg: (event) ->
    if event.source != @_w
      return
    @_decode_msg event.data

  _ref: (iframe) ->
    @_iframe = iframe
    if iframe?
      # init (mount)
      @_w = iframe.contentWindow
      # add event listener
      window.addEventListener 'message', @_on_msg, false
    else  # umount
      # remove event listener
      window.removeEventListener 'message', @_on_msg
      @_w = null

  _make_src: ->
    q = {
      app_id: @props.app_id
      ssad_key: @props.ssad_key
      show_path: true
      # TODO support more args ?
    }
    # o
    ssad_server_api.SSAD_FILE_LIST + '?' + querystring.stringify(q)

  render: ->
    (cE 'div', {
      className: 'sub_file_list'
      },
      (cE 'iframe', {
        src: @_make_src()
        ref: @_ref
        })
    )
}

module.exports = FileList
