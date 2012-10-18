# An implementation of Dijkstra's algorithm using ruby

class Dijkstra

  Vertex = Struct.new(:node, :neighbor, :distance, :previous)
  Edge = Struct.new(:vertices, :l)

  def initialize(graph)
    @vertices = {}
    @edges = []
    @unoptimized_nodes = []
    @infinity = 1.0/0.0
    graph.each do |v1, v2, l|
      @vertices[v1] = Vertex.new(v1, [], @infinity, []) if !@vertices.has_key?(v1)
      @vertices[v2] = Vertex.new(v2, [], @infinity, []) if !@vertices.has_key?(v2)
      vertex1 = @vertices[v1]
      vertex2 = @vertices[v2]
      vertex1.neighbor << v2
      vertex2.neighbor << v1
      @edges << Edge.new([v1,v2],l)
    end
  end

  # Find the shortest path that exists for all nodes to the starter node

  def shortest_path(source)
    @vertices[source].distance = 0
    self.distances(source)
    @vertices.each do |vert|
      @unoptimized_nodes << vert[0]
    end
    @unoptimized_nodes.delete_if{|x| x == source}
    while @unoptimized_nodes.length > 0
      self.step_forward
    end
    @vertices.each do |vert|
      vertex = vert[0]
      distance = vert[1].distance
      previousnodes = vert[1].previous
      puts "#{vertex} is #{distance} units from source node #{source} through nodes #{previousnodes}"
    end
  end

  # Get the shortest path from the unoptimized list of nodes

  def return_shortest
    @min = @infinity
    @node = ""
    @unoptimized_nodes.each do |node|
      if @vertices[node].distance <= @min
        @min = @vertices[node].distance
        @node = @vertices[node].node
        @unoptimized_nodes.delete_if{|x| x == @node}
      end
    end
    return @node
  end

  # Step forward in the algorithm

  def step_forward
    shortest_node = self.return_shortest
    self.distances(shortest_node)
  end

  # Find the edges for the new node and assign costs to the possible edges
  def find_edge(s, e)
    dist = @infinity
    @edges.each do |edge|
      if edge.vertices[0] == s && edge.vertices[1] == e
        dist =  edge.l
      end
    end
    return dist
  end

  # Find the distances between all nodes and start

  def distances(start)
   @vertices.each do |vert|
      vertex = vert[1]
      path_len = 0
      case
      when vertex.distance <= @vertices[start].distance
      else 
        path_len = @vertices[start].distance + self.find_edge(start, vertex.node)
        if vertex.distance > path_len
          vertex.distance = path_len
          vertex.previous = [@vertices[start].previous, start].flatten
        end
      end
    end
  end

end
