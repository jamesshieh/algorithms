require "./contsubseq"
require "tracer"

list = [5,15,-30,10,-5,40,10,2,5,-10,-20,3,40,30,-40,45,20,-10,15,20]
sorter = ContinuousSequence.new(list)
sorter.max_conseq
