vlib work
vlog -timescale 1ns/1ns sequence_detector.v
vsim sequence_detector
log {/*}
add wave {/*}

#first test case
#force {KEY[0]} 0 0, 1 1 -repeat 2
#force {SW[1]} 0 0, 1 4
#force {SW[0]} 0 0, 1 2 
#run 20ns

#second test case
force {KEY[0]} 0 0, 1 1 -repeat 2
force {SW[1]} 0 0, 1 4, 1 6, 0 8, 1 10, 1 12
force {SW[0]} 0 0, 1 2 
run 20ns
