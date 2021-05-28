def primes(max)
  return [] if max < 2

  l = Array.new(max + 1) { |x| x % 2 == 1 }
  l = [true] * (max + 1)

  arr = [2]

  p = 3

  while p <= max
    if l[p]
      arr << p

      factor = 3
      p_mult = p * factor

      while p_mult <= max
        l[p_mult] = false
        factor += 1
        p_mult = p * factor
      end
    end

    p += 2
  end

  arr
end

# fail unless primes(0)   == []
# fail unless primes(2)   == [2]
# fail unless primes(10)  == [2, 3, 5, 7]
# fail unless primes(100) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
