require 'kruskal'

graph = (



kruskal = Kruskal.new(graph)
kruskal.generate_mst
puts kruskal.mst
