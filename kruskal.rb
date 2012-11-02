require 'debugger'

class Kruskal
  attr_accessor :mst

  Edge = Struct.new(:vertices, :cost)

  def initialize(graph)
    @mst = []
    @edges = []
    @unmapped_nodes = []
    @costs = {}
    @mstsets = []
    graph.each do |v1, v2, c|
      @edges << Edge.new([v1, v2],c)
      @unmapped_nodes << v1 if !@unmapped_nodes.include?(v1)
      @unmapped_nodes << v2 if !@unmapped_nodes.include?(v2)
      @costs[c] = [] if !@costs.has_key?(c)
      @costs[c] << [v1,v2]
    end
  end

  def find(x)
    @mstsets.each do |set|
      return set if set.include?(x)
    end
    return [x]
  end

  def new_edge?(edge)
    @mstsets.each do |set|
      return !(set.include?(edge[0]) && set.include?(edge[1]))
    end
  end

  def generate_mst
    @costs.sort.each do |cost, edges|
      edges.each do |edge|
        if self.new_edge?(edge)
          set1 = find(edge[0])
          set2 = find(edge[1])
          @mstsets.delete(set1)
          @mstsets.delete(set2)
          @mstsets << (set1 | set2)
          @mst << Edge.new(edge,cost)
        end
      end
    end
  end

end

