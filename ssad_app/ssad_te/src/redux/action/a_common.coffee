# a_common.coffee, ssad/ssad_app/ssad_te/src/redux/action/


# action types
C_SET_DOC_CLEAN = 'c_set_doc_clean'


set_doc_clean = (is_clean) ->
  {
    type: C_SET_DOC_CLEAN
    payload: is_clean
  }

module.exports = {
  C_SET_DOC_CLEAN

  set_doc_clean
}
