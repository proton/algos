require 'benchmark'

load "#{File.dirname(__FILE__)}/quick_find.rb"
load "#{File.dirname(__FILE__)}/quick_union.rb"
load "#{File.dirname(__FILE__)}/quick_union_weighted.rb"

n = 10000
connections = 5000.times.map { [rand(n), rand(n)] }
checks = 5000.times.map { [rand(n), rand(n)] }

classes = [QuickFind, QuickUnion, QuickUnionWeighted]

classes.each do |klass|
  uf = klass.new(n)
  connect_time = Benchmark.measure do
    connections.each do |(x, y)|
      uf.union(x, y)
    end
  end
  check_time = Benchmark.measure do
    checks.each do |(x, y)|
      uf.connected?(x, y)
    end
  end

  p [klass.name, connect_time.total, check_time.total]
end