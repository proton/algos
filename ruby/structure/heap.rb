class Heap
  attr_reader :arr

  def initialize(values = [])
    @arr = values

    (arr.size / 2 - 1).downto(0).each do |i|
      heapify!(i)
    end
  end

  def push(value)
    i = arr.size
    arr << value
    parent_i = (i - 1) / 2

    while i > 0 && arr[parent_i] < arr[i]
      swap(i, parent_i)
      i = parent_i
      parent_i = (i - 1) / 2
    end
  end

  def max
    arr.first
  end

  def pop
    value = arr[0]
    last  = arr.pop
    unless arr.empty?
      arr[0] = last
      heapify!(0)
    end
    value
  end

  def length
    arr.size
  end

  def merge(heap2)
    while heap2.max
      push(heap2.pop)
    end
  end

  private def heapify!(i)
    loop do
      left_child  = 2 * i + 1
      right_child = 2 * i + 2
      largest_child = i

      largest_child = left_child  if left_child  < arr.size && arr[left_child]  > arr[largest_child]
      largest_child = right_child if right_child < arr.size && arr[right_child] > arr[largest_child]

      break if largest_child == i

      swap(i, largest_child)
      i = largest_child
    end
  end

  private def swap(i, j)
    arr[i], arr[j] = arr[j], arr[i]
  end
end

# arr = 10.times.map { rand(0..9) }
# arr1 = arr.shuffle
# arr2 = arr.shuffle
# arr3 = arr.shuffle

# heap1 = Heap.new(arr1)
# heap2 = Heap.new(arr2)
# heap3 = Heap.new(arr3)
# heap4 = Heap.new; arr.each { |x| heap4.push(x) }
# heap5 = Heap.new; arr.reverse.each { |x| heap5.push(x) }

# heaps = [heap1, heap2, heap3, heap4, heap5]

# fail unless heaps.map(&:max).uniq == [arr.max]

# while heaps.first.length > 0
#   fail unless heaps.map(&:max).uniq.size == 1
#   fail unless heaps.map(&:max).uniq.size == 1
#   fail unless heaps.map(&:pop).uniq.size == 1
# end
