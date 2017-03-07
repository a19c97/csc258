vlib work
vlog -timescale 1ns/1ns sequence_detector.v
vsim sequence_detector
log {/*}
add wave {/*}

#first test case
force {KEY[0]} 0 0, 1 1 -repeat 2
force {SW[1]} 0 0, 1 4, 1 5, 1 6, 1 7
force {SW[0]} 0 0, 1 2 
run 10ns

#first test case
force {KEY[0]} 0 0, 1 1 -repeat 2
force {SW[1]} 0 0, 1 4, 1 5, 0 6, 1 7
force {SW[0]} 0 0, 1 2 
run 10ns