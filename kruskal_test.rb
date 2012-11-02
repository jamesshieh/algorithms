require './kruskal'
require 'tracer'

graph = [
  ['a','b',1],
  ['b','c',1],
  ['a','c',2],
  ['a','d',3],
  ['d','e',2]
]
Tracer.on
kruskal = Kruskal.new(graph)
kruskal.generate_mst
puts kruskal.mst
Tracer.off
