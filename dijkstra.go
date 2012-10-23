package main

import(
  "fmt"
  "math"
)

const inf = math.MaxInt32

type Edge struct {
  edge1, edge2 string
  cost int
}

type Vertex struct{
  Node string
  Neighbors []string
  Distance int
  Previous []string
}

func initializeVertices(graph []Edge, start string) map[string]*Vertex {
// Initialize data structure based on edge inputs and create vertex map
  vertices := make(map[string]*Vertex)
  for _, v := range graph {
    if vertices[v.edge1] == nil{
      vertices[v.edge1] = &Vertex{Node: v.edge1}
    }
    if vertices[v.edge2] == nil{
      vertices[v.edge2] = &Vertex{Node: v.edge2}
    }
  }
  for _, v := range graph {
    vertices[v.edge1].Neighbors = append(vertices[v.edge1].Neighbors, v.edge2)
  }
  for _, v := range vertices {
    v.Distance = inf
  }
  vertices[start].Distance = 0
  for _, v := range graph {
    if v.edge1 == start {
      vertices[v.edge2].Distance = v.cost
    }
  }
  return vertices
}

func scanEdges(graph []Edge, vertices map[string]*Vertex, current string){
  for _, e := range graph {
    if e.edge1 == current {
      if vertices[e.edge2].Distance > (e.cost + vertices[e.edge1].Distance) {
        vertices[e.edge2].Distance = e.cost + vertices[e.edge1].Distance
        vertices[e.edge2].Previous = append(vertices[e.edge2].Previous, e.edge1)
        vertices[e.edge2].Previous = append(vertices[e.edge2].Previous, vertices[e.edge1].Previous...)
      }
    }
  }
}

func nextAlarm(unopt []string, vertices map[string]*Vertex) (string, int) {
// Trigger alarm for next node that is hit
  min := inf
  var nodeindex int
  var optnode string
  for i, v := range unopt {
    if vertices[v].Distance < min {
      min = vertices[v].Distance
      optnode = vertices[v].Node
      nodeindex = i
    }
  }
  return optnode, nodeindex
}

func traverse(graph []Edge, vertices map[string]*Vertex, start string){
// Traverse the paths and until the next alarm
  var unopt []string
  for _, v := range vertices {
    if v.Node != start {
      unopt = append(unopt, v.Node)
    }
  }
  for len(unopt) > 0 {
    node, nodeindex := nextAlarm(unopt, vertices)
    scanEdges(graph, vertices, node)
    unopt = append(unopt[:nodeindex], unopt[nodeindex+1:]...)
  }
}

func main() {
// Initial input data
  graph := []Edge{
    {"a", "b", 7},
    {"a", "c", 9},
    {"a", "f", 14},
    {"b", "c", 10},
    {"b", "d", 15},
    {"c", "d", 11},
    {"c", "f", 2},
    {"d", "e", 6},
    {"e", "f", 9},
  }

  start := "a"
  vertices := initializeVertices(graph, start)
  traverse(graph, vertices, start)
  for _, v := range vertices {
    fmt.Print(v)
    fmt.Printf("\n")
  }
}
