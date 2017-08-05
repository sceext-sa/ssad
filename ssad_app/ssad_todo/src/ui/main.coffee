# main.coffee, ssad/ssad_app/ssad_todo/src/ui/
# css class: main_host

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

Nav = require './redux/nav/n_connect'
# sub pages
CWelcome = require './redux/connect/c_welcome'
CEnableTaskList = require './redux/connect/c_enable_task_list'
  COneTask = require './redux/connect/c_one_task'
    CChangeStatus = require './redux/connect/c_change_status'
  CEditCreateTask = require './redux/connect/c_edit_create_task'
CMainMenu = require './redux/connect/c_main_menu'
  CDisabledList = require './redux/connect/c_disabled_list'
  CAbout = require './redux/connect/c_about'
  CConfig = require './redux/connect/c_config'


Main = cC {
  displayName: 'Main'
  propTypes: {
    # TODO
  }

  render: ->
    (cE 'div', {
      className: 'main_host'
      },
      (cE Nav, null,
        # all pages
        (cE CWelcome, { id: 'page_welcome' })
        (cE CEnableTaskList, { id: 'page_enable_task_list' })
          (cE COneTask, { id: 'page_one_task' })
            (cE CChangeStatus, { id: 'page_change_status' })
          (cE CEditCreateTask, { id: 'page_edit_create_task' })
        (cE CMainMenu, { id: 'page_main_menu' })
          (cE CDisabledList, { id: 'page_disabled_list' })
          (cE CAbout, { id: 'page_about' })
          (cE CConfig, { id: 'page_config' })
      )
      # TODO show load-task / doing-operate ?
    )
}

module.exports = Main
