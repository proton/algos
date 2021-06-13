require 'set'

class Graph
  attr_reader :graph

  def initialize
    @graph = {}
  end

  def nodes
    @graph.keys
  end

  def add_edge(from, to, distance)
    connect(from, to,   distance)
    connect(to,   from, distance)
  end

  def connect(from, to, distance)
    graph[from] ||= {}
    graph[from][to] = distance
  end

  def neighbours(node)
    graph[node].keys
  end

  def distance(from, to)
    graph[from][to]
  end
end

class Dijkstra
  attr_reader :graph

  INFINITY = 1.0/0.0

  def initialize(graph)
    @graph = graph
  end

  def calculate_distances(from)
    distances = Hash.new(INFINITY)
    distances[from] = 0

    unvisited = Set.new
    unvisited << from

    while unvisited.any?
      node = unvisited.min_by { |node| distances[node] }
      unvisited.delete(node)

      graph.neighbours(node).each do |neighbour|
        new_distance = distances[node] + graph.distance(node, neighbour)

        if new_distance < distances[neighbour]
          distances[neighbour] = new_distance
          unvisited << neighbour
        end
      end
    end

    distances
  end
end


# Sample input from https://en.wikipedia.org/wiki/Dijkstra's_algorithm
graph = Graph.new
graph.add_edge(:a, :c, 7)
graph.add_edge(:a, :e, 14)
graph.add_edge(:a, :f, 9)
graph.add_edge(:c, :d, 15)
graph.add_edge(:c, :f, 10)
graph.add_edge(:d, :f, 11)
graph.add_edge(:d, :b, 6)
graph.add_edge(:f, :e, 2)
graph.add_edge(:e, :b, 9)

distances = Dijkstra.new(graph).calculate_distances(:a)

fail unless distances[:a] == 0
fail unless distances[:b] == 20
fail unless distances[:c] == 7
fail unless distances[:d] == 20
fail unless distances[:e] == 11
fail unless distances[:f] == 9
