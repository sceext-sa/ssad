# r_util.coffee, ssad/ssad_app/ssad_te/src/redux/


# check should display filename, return null if not
get_filename = ($$state) ->
  f = $$state.get('file').toJS()
  if (! f.sub_root?) || (! f.sub_path?) || (! f.root_path?) || (! f.path?) || (! f.filename?) || ('' == f.filename)
    return null
  f.filename

# check need config app_id/ssad_key
check_key = ($$state) ->
  if (! $$state.get('app_id')?) || (! $$state.get('ssad_key')?) || $$state.getIn(['config', 'error'])?
    return true
  false


module.exports = {
  get_filename
  check_key
}
