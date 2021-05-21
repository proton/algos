def greatest_common_divisor(a, b)
  return a if b.zero?
  greatest_common_divisor(b, a % b)
end
