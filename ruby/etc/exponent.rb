def exponent(base, power)
  result = 1

  factor = base

  while power > 0
    result *= factor if power % 2 == 1
    factor *= factor
    power /= 2
  end

  result
end

# fail unless exponent(2,  0) ==  2**0
# fail unless exponent(2,  3) ==  2**3
# fail unless exponent(11, 5) == 11**5
# fail unless exponent(17, 7) == 17**7
# fail unless exponent(17, 8) == 17**8
# fail unless exponent(17, 9) == 17**9
