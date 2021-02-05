class QuickUnion
  attr_reader :parents, :length

  def initialize(n)
    @parents = Array.new(n) { |i| i }
    @length = n
  end

  def connected?(a, b)
    root(a) == root(b)
  end

  def union(a, b)
    a_root = root(a)
    b_root = root(b)
    return if a_root == b_root

    parents[b_root] = a_root

    @length -= 1
  end

  private def root(x)
    x = parents[x] until x == parents[x]
    x
  end
end

# uf = QuickUnion.new(10)
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
