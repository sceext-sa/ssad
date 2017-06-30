# count.coffee, ssad/ssad_app/ssad_te/src/


# sub count methods

_count_chars = (text) ->
  text.length

_count_lines = (text) ->
  text.split('\n').length

_count_no_empty_lines = (text) ->
  l = text.split '\n'
  o = 0
  for i in l
    if i.trim() != ''
      o += 1
  o

_count_no_empty_chars = (text) ->
  # no ASCII control chars (> 32  ' ')
  o = 0
  for i in [0... text.length]
    if text.charCodeAt(i) > 32
      o += 1
  o

_count_words = (text) ->
  l = text.split '\n'
  o = 0
  for i in l
    w = i.split ' '
    for j in w
      if j.trim() != ''
        o += 1
  o

_count_no_ascii_chars = (text) ->
  # MAX ascii char == 127
  o = 0
  for i in [0... text.length]
    if text.charCodeAt(i) > 127
      o += 1
  o


count = (text) ->
  o = {
    chars: _count_chars text
    lines: _count_lines text
    no_empty_lines: _count_no_empty_lines text
    no_empty_chars: _count_no_empty_chars text
    words: _count_words text
    no_ascii_chars: _count_no_ascii_chars text
  }
  # more counts
  o.empty_lines = o.lines - o.no_empty_lines
  o.empty_chars = o.chars - o.no_empty_chars
  o.ascii_chars = o.chars - o.no_ascii_chars
  o['words+no_ascii_chars'] = o.words + o.no_ascii_chars

  o

module.exports = count
