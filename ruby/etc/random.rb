class Random
  # Random constants
  A = 48271
  B = 0
  M = 2**31 - 1

  attr_reader :value

  def initialize(seed: nil)
    @value = seed || Time.now.nsec
  end

  def next
    @value = (A * value + B) % M
    value
  end
end

# random = Random.new
# 20.times { puts random.next }
