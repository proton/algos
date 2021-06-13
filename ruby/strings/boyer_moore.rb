def boyer_moore(string, substring)
  substring_chars = Hash.new(-1)
  substring.each_char.with_index do |char, index|
    substring_chars[char] = index
  end

  found = []

  i = 0
  while i <= string.size - substring.size
    j = substring.size - 1

    j -= 1 while j >= 0 && substring[j] == string[i + j]

    if j < 0
      found << i

      if i + substring.size < string.size
        i += substring.size - substring_chars[string[i + substring.size]]
      else
        i += 1
      end
    else
      i += [1, j - substring_chars[string[i + j]]].max
    end
  end

  found
end

fail unless boyer_moore("abcabcdcabcabcabcabdcabbeabb", "abcabca") == [8, 11]
