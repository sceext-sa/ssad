# p_count.coffee, ssad/ssad_app/ssad_te/src/page/
# css class: page, p_count, count_item

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Glyphicon
} = require 'react-bootstrap'

NavTop = require '../sub/nav_top'


CountItem = cC {
  displayName: 'CountItem'
  propTypes: {
    id: PropTypes.string.isRequired
    text: PropTypes.string.isRequired
    value: PropTypes.number.isRequired
    main: PropTypes.string.isRequired

    on_set_main: PropTypes.func.isRequired
  }

  _is_main: ->
    (@props.id == @props.main)

  _on_click: ->
    @props.on_set_main @props.id

  _render_main_mark: ->
    if @_is_main()
      (cE 'span', {
        className: 'main_mark'
        },
        (cE Glyphicon, {
          glyph: 'ok'
          })
      )
    else
      (cE 'span', {
        className: 'main_mark'
        },
        ' '
      )

  render: ->
    c = 'count_item'
    if @_is_main()
      c += ' active'

    (cE 'li', {
      className: c
      onClick: @_on_click
      },
      @_render_main_mark()
      (cE 'span', {
        className: 'text'
        },
        @props.text
      )
      (cE 'span', {
        className: 'value'
        },
        @props.value.toString()
      )
    )
}

PCount = cC {
  displayName: 'PCount'
  propTypes: {
    info: PropTypes.object.isRequired
    main: PropTypes.string.isRequired

    on_set_main: PropTypes.func.isRequired
    on_refresh: PropTypes.func.isRequired
    on_nav_back: PropTypes.func.isRequired
  }

  render: ->
    (cE 'div', {
      className: 'page p_count'
      },
      (cE NavTop, {
        title: 'Count'
        on_back: @props.on_nav_back
        },
        # refresh button
        (cE 'span', {
          className: 'right_refresh'
          onClick: @props.on_refresh
          },
          (cE Glyphicon, {
            glyph: 'refresh'
            })
        )
      )
      (cE 'div', {
        className: 'page_body'
        },
        (cE 'ul', null,
          (cE CountItem, {
            id: 'chars'
            text: 'char'
            value: @props.info.chars
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'lines'
            text: 'line'
            value: @props.info.lines
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'no_empty_lines'
            text: 'no EMPTY line'
            value: @props.info.no_empty_lines
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'no_empty_chars'
            text: 'no EMPTY char'
            value: @props.info.no_empty_chars
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'words'
            text: 'word'
            value: @props.info.words
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'no_ascii_chars'
            text: 'no ASCII char'
            value: @props.info.no_ascii_chars
            main: @props.main
            on_set_main: @props.on_set_main
            })
        )
        # ---
        (cE 'hr')
        (cE 'ul', null,
          (cE CountItem, {
            id: 'empty_lines'
            text: 'EMPTY line'
            value: @props.info.empty_lines
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'empty_chars'
            text: 'EMPTY char'
            value: @props.info.empty_chars
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'ascii_chars'
            text: 'ASCII char'
            value: @props.info.ascii_chars
            main: @props.main
            on_set_main: @props.on_set_main
            })
          (cE CountItem, {
            id: 'words+no_ascii_chars'
            text: 'words + no ASCII char'
            value: @props.info['words+no_ascii_chars']
            main: @props.main
            on_set_main: @props.on_set_main
            })
        )
      )
    )
}

module.exports = PCount
