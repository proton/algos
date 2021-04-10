# Fisher–Yates shuffle / Knuth shuffle
# Durstenfeld's version

def knuth_shuffle(array)
  (array.size - 1).downto(1) do |i|
    k = rand(0..i)
    array[k], array[i] = array[i], array[k] unless i == k
  end
  array
end

# array = (0..9).to_a

# p array
# p knuth_shuffle(array)
