class Prim

  Vertex = Struct.new(:node, :distance, :previous)
  Edge = Struct.new(:vertices, :l)

  def initialize(graph)
    @vertices = {}
    @edges = []
    @unoptimized_nodes = []
    @infinity = 1.0/0.0
    graph.each do |v1, v2, l|
      @vertices[v1] = Vertex.new(v1, @infinity, '') if !@vertices.has_key?(v1)
      @vertices[v2] = Vertex.new(v2, @infinity, '') if !@vertices.has_key?(v2)
      @edges << Edge.new([v1,v2],l)
    end
  end

  # Create a MST starting from source node using prim's algorithm which
  # adds nodes in order of edge length

  def generate_mst(source)
    @vertices[source].distance = 0
    self.distances(source)
    @vertices.each do |vert|
      @unoptimized_nodes << vert[0]
    end
    @unoptimized_nodes.delete_if{|x| x == source}
    while @unoptimized_nodes.length > 0
      self.step_forward
    end
    puts "The edges for the MST are below:"
    @vertices.each do |vert|
      edge1 = vert[1].node
      edge2 = vert[1].previous
      if edge2 != ''
        puts "#{edge1} to #{edge2}"
      end
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

  # Find edge if it exists

  def find_edge(s, e)
    dist = @infinity
    @edges.each do |edge|
      if edge.vertices[0] == s && edge.vertices[1] == e
        dist =  edge.l
      end
    end
    return dist
  end

  # Set possible distances to node

  def distances(start)
   @vertices.each do |vert|
      vertex = vert[1]
      if vertex.distance <= @vertices[start].distance
      else
        path_len = self.find_edge(start, vertex.node)
        if vertex.distance > path_len
          vertex.distance = path_len
          vertex.previous = start
        end
      end
    end
  end

end
