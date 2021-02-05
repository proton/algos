class QuickFind
  attr_reader :roots

  def initialize(n)
    @roots = Array.new(n) { |i| i }
  end

  def connected?(a, b)
    roots[a] == roots[b]
  end

  def union(a, b)
    a_root = roots[a]
    b_root = roots[b]
    roots.each_with_index do |x, i|
      roots[i] = a_root if x == b_root
    end
  end
end

# uf = QuickFind.new(10)
# uf.union(4, 3)
# uf.union(3, 8)
# uf.union(6, 5)
# uf.union(9, 4)
# uf.union(2, 1)

# fail unless uf.connected?(0, 7) == false
# fail unless uf.connected?(8, 9) == true

# uf.union(5, 0)
# uf.union(7, 2)
# uf.union(6, 1)
# uf.union(1, 0)

# fail unless uf.connected?(0, 7) == true
