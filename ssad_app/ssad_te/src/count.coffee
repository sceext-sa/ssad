# count.coffee, ssad/ssad_app/ssad_te/src/

LF = '\n'
SP = ' '  # space
NULL = ''  # empty string

ASCII_MAX_CONTROL = 32  # max ASCII control char: ' '  (32)
ASCII_MAX = 127


# sub count methods

_count_chars = (text) ->
  text.length

_count_lines = (text) ->
  text.split(LF).length

_count_no_empty_lines = (text) ->
  l = text.split LF
  o = 0
  for i in l
    if i.trim() != NULL
      o += 1
  o

_count_no_empty_chars = (text) ->
  o = 0
  for i in [0... text.length]
    if text.charCodeAt(i) > ASCII_MAX_CONTROL
      o += 1
  o

_count_no_ascii_chars = (text) ->
  o = 0
  for i in [0... text.length]
    if text.charCodeAt(i) > ASCII_MAX
      o += 1
  o

# count words

_W_ASCII = 'w_ascii'  # pure ASCII char words
_W_NO_ASCII = 'w_no_ascii'  # pure no ASCII char words
_W_MIX = 'w_mix'  # mix char words

_check_word_type = (w) ->
  has_ascii = false
  has_no_ascii = false
  for i in [0... w.length]
    if w.charCodeAt(i) > ASCII_MAX
      has_no_ascii = true
      if has_ascii
        return _W_MIX
    else
      has_ascii = true
      if has_no_ascii
        return _W_MIX
  if has_ascii && (! has_no_ascii)
    return _W_ASCII
  else if has_no_ascii && (! has_ascii)
    return _W_NO_ASCII
  return _W_MIX

_count_words = (text) ->
  o = {
    words: 0  # all words
    words_ascii: 0  # pure ASCII char words
    words_no_ascii: 0  # pure no ASCII char words
    words_mix: 0  # mix char words
  }
  l = text.split LF
  for i in l
    w = i.split SP
    for j in w
      one = j.trim()
      if one != NULL
        switch _check_word_type one
          when _W_ASCII
            o.words_ascii += 1
          when _W_NO_ASCII
            o.words_no_ascii += 1
          when _W_MIX
            o.words_mix += 1
        o.words += 1
  o


_count = (text) ->
  # base counts
  o = {
    chars: _count_chars text
    lines: _count_lines text
    no_empty_lines: _count_no_empty_lines text
    no_empty_chars: _count_no_empty_chars text
    no_ascii_chars: _count_no_ascii_chars text
  }
  # count words
  Object.assign o, _count_words text
  # more counts
  o.empty_lines = o.lines - o.no_empty_lines
  o.empty_chars = o.chars - o.no_empty_chars
  o.ascii_chars = o.chars - o.no_ascii_chars
  o['words+no_ascii_chars'] = o.words + o.no_ascii_chars
  o['words_ascii+no_ascii_chars'] = o.words_ascii + o.no_ascii_chars

  o

count = (text) ->
  # DEBUG
  console.log "DEBUG: count #{text.length}"
  _count text

module.exports = count
