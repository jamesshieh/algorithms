package main

import(
  "fmt"
)

func summedArray(list []int) []int {
  var sumlist []int
  for i, v  := range list {
    sumlist = append(sumlist, sum(list[:i]))
  }
  return sumlist
}

func main() {
  list := []int{5,15,-30,10,-5,40,10}
  fmt.Printf(summedArray(list))
}
