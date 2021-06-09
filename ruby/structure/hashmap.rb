HashMapNode = Struct.new(:key, :value)

class HashMap
  attr_reader :table

  def initialize(volume = 10)
    @table = Array.new(volume)
    @size  = 0
  end

  def put(key, value)
    index = hash(key)
    table[index] ||= []
    node = find_node(key)
    if node
      node.value = value
    else
      table[index] << HashMapNode.new(key, value)
    end
  end

  def get(key)
    find_node(key)&.value
  end

  def delete(key)
    index = hash(key)
    return if table[index].nil?
    table[index].delete_if { |node| node.key == key }
  end

  def keys
    table.compact.flatten.map(&:key)
  end

  def to_h
    table.compact.flatten.to_h { |node| [node.key, node.value] }
  end

  private def find_node(key)
    index = hash(key)
    table[index]&.find { |node| node.key == key }
  end

  private def hash(key)
    # TODO: implement a hash function
    key.hash % table.size
  end
end

# h0 = {}
# h1 = HashMap.new

# 10000.times do |i|
#   key   = rand(100)
#   value = rand(1000)

#   if [false, true].sample
#     h0[key] = value
#     h1.put(key, value)
#   else
#     h0.delete(key)
#     h1.delete(key)
#   end

#   raise "ERR" unless h0.keys.sort == h1.keys.sort
#   raise "ERR" unless h0 == h1.to_h
# end
# puts "OK"
