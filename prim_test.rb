require './prim'

graph = [
  [1,2,3],
  [2,3,1],
  [1,3,2],
  [4,5,2],
  [3,4,1]
]

prim = Prim.new(graph)
prim.generate_mst(1)
