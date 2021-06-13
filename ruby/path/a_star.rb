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

class AStar
  attr_reader :graph

  INFINITY = 1.0/0.0

  def initialize(graph)
    @graph = graph
  end

  def find_path(from, to)
    visited   = Set.new
    unvisited = Set.new([from])

    came_from = {}

    distances = Hash.new(INFINITY)
    distances[from] = 0

    estimated_distances = Hash.new(INFINITY)
    estimated_distances[from] = graph.distance(from, to)

    while unvisited.any?
      current = unvisited.min_by { |node| estimated_distances[node] }

      return reconstruct_path(current, came_from) if current == to

      unvisited.delete(current)
      visited << current

      graph.neighbours(current).each do |neighbor|
        next if visited.include?(neighbor)

        new_distance = distances[current] + graph.distance(current, neighbor)

        if !unvisited.include?(neighbor) || new_distance < distances[neighbor]
          came_from[neighbor] = current
          distances[neighbor] = new_distance
          estimated_distances[neighbor] = distances[neighbor] + estimated_distance(neighbor, to)
          unvisited << neighbor
        end
      end
    end

    # No path found
    return nil
  end

  private def reconstruct_path(current, came_from)
    path = []
    while current
      path.unshift(current)
      current = came_from[current]
    end
    path
  end

  private def estimated_distance(from, to)
    graph.distance(from, to) || INFINITY
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

astar = AStar.new(graph)

fail unless astar.find_path(:a, :b) == %i[a e b]
fail unless astar.find_path(:a, :c) == %i[a c]
fail unless astar.find_path(:a, :d) == %i[a f d]
fail unless astar.find_path(:a, :e) == %i[a f e]
fail unless astar.find_path(:a, :f) == %i[a f]
