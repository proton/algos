private def prefix_function(string)
  borders = Array.new(string.size, 0)

  (1...string.size).each do |i|
    prev_border = borders[i - 1]

    while prev_border > 0 && string[i] != string[prev_border]
      prev_border = borders[prev_border - 1]
    end

    prev_border += 1 if string[i] == string[prev_border]

    borders[i] = prev_border
  end

  borders
end

### Knuth-Morris-Pratt algorithm

def knuth_morris_pratt(string, substring)
  prefixes = prefix_function(substring)

  i = j = 0
  found = []

  while i < string.size
    if string[i] == substring[j]
      i += 1
      j += 1
    end

    if j == substring.size
      found << i - j
      j = prefixes[j - 1]
    elsif i < string.size && string[i] != substring[j]
      if j != 0
        j = prefixes[j - 1]
      else
        i += 1
      end
    end
  end

  found
end

# fail unless knuth_morris_pratt("abcabcdcabcabcabcabdcabbeabb", "abcabca") == [8, 11]
