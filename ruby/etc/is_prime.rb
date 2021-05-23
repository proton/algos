def is_prime?(num)
  return false if num < 2

  # Fermat's little theorem
  10.times do
    i = rand(1...num)
    return false if i.pow(num - 1, num) != 1
  end

  # A head-on solution
  (2..(num ** 0.5)).each do |n|
    return false if num % n == 0
  end

  true
end

fail unless is_prime?(0)  == false
fail unless is_prime?(1)  == false
fail unless is_prime?(5)  == true
fail unless is_prime?(10) == false
fail unless is_prime?(11) == true
fail unless is_prime?(16) == false
fail unless is_prime?(17) == true
fail unless is_prime?(31) == true
fail unless is_prime?(32) == false
