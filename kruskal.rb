class Kruskal

  Edge = Struct.new(:vertices, :cost)

  def initialize(graph)
    @mst = []
    @edges = []
    @unmapped_nodes = []
    graph.each do |v1, v2, c|
      @edges << Edge.new([v1, v2],c)
      @unmapped_nodes << v1 unless @unmapped_nodes.include?(v1)
      @unmapped_nodes << v2 unless @unmapped_nodes.include?(v2)
    end
    @costs = {}
    @edges.each do |e|
      @costs[e.cost] = [] if !@costs.has_key?[e.cost]
      @costs[e.cost] << e.vertices
    end
  end


  def generate_mst
    generator = @costs.sort.each
    mstnodes = []
    generator.each do |cost, edges|
      for edges.each do |edge|
        if mstnodes.include?(edge[0]) && mstnodes.include?(edge[1])
          @mst << Edge.new(edges,cost)
          mstnodes << edge[0], edge[1]
        end
      end
    end
  end

end

