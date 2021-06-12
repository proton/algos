def prefix_function(string)
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

# fail unless prefix_function("ABABCABAB").join == "001201234"
