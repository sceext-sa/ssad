# p_main_menu.coffee, ssad/ssad_app/ssad_todo/src/ui/page/
# css class: page, p_main_menu

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

NavTop = require '../sub/nav_top'
SubItem = require '../sub/sub_item'
AddButton = require '../sub/add_button'


Page = cC {
  displayName: 'PMainMenu'
  propTypes: {
    on_create_task: PropTypes.func.isRequired

    on_nav_back: PropTypes.func.isRequired
    on_nav: PropTypes.func.isRequired
  }

  _on_nav_task_list: ->
    @props.on_nav 'page_enable_task_list'
  _on_nav_disabled_task: ->
    @props.on_nav 'page_disabled_list'
  _on_nav_config: ->
    @props.on_nav 'page_config'
  _on_nav_about: ->
    @props.on_nav 'page_about'

  _on_add_task: ->
    @props.on_create_task()

  render: ->
    (cE 'div', {
      className: 'page p_main_menu'
      },
      (cE NavTop, {
        title: 'SSAD todo'
        title_center: true
        })
      (cE 'div', {
        className: 'page_body'
        },
        (cE SubItem, {
          text: 'Task list'
          on_click: @_on_nav_task_list
          })
        (cE SubItem, {
          text: 'Disabled tasks'
          on_click: @_on_nav_disabled_task
          })
        # add button
        (cE 'div', {
          className: 'add_button'
          },
          (cE AddButton, {
            on_click: @_on_add_task
            })
        )
        (cE SubItem, {
          text: 'Config'
          on_click: @_on_nav_config
          })
        (cE SubItem, {
          text: 'About'
          on_click: @_on_nav_about
          })
      )
    )
}

module.exports = Page
