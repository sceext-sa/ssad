# n_action.coffee, ssad/ssad_app/ssad_te/src/redux/nav/


# action types
NAV_BACK = 'nav_back'
NAV_GO = 'nav_go'

back = ->
  {
    type: NAV_BACK
  }

go = (id) ->
  {
    type: NAV_GO
    payload: id
  }

module.exports = {
  NAV_BACK
  NAV_GO

  back
  go
}
