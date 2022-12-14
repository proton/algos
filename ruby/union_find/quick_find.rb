class QuickFind
  attr_reader :parents, :length

  def initialize(n)
    @parents = Array.new(n) { |i| i }
    @length = n
  end

  def connected?(a, b)
    parents[a] == parents[b]
  end

  def union(a, b)
    a_root = parents[a]
    b_root = parents[b]
    return if a_root == b_root

    parents.each_with_index do |x, i|
      parents[i] = a_root if x == b_root
    end

    @length -= 1
  end
end

# uf = QuickFind.new(10)
# uf.union(4, 3)
# uf.union(3, 8)
# uf.union(6, 5)
# uf.union(9, 4)
# uf.union(2, 1)

# fail unless uf.length == 5
# fail unless uf.connected?(0, 7) == false
# fail unless uf.connected?(8, 9) == true

# uf.union(5, 0)
# uf.union(7, 2)
# uf.union(6, 1)
# uf.union(1, 0)

# fail unless uf.length == 2
# fail unless uf.connected?(0, 7) == true