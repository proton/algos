def factors(n)
  arr = []

  add_divisors = lambda do |y|
    while n % y == 0
      arr << y
      n /= y
    end
  end

  add_divisors.call(2)

  i = 3
  max_factor = n ** 0.5
  while i <= max_factor
    add_divisors.call(i)
    i += 2
  end

  arr << n if n > 1

  arr
end

# fail unless factors(1)       == []
# fail unless factors(12)      == [2, 2, 3]
# fail unless factors(17 * 23) == [17, 23]
