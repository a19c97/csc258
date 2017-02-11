vlib work
vlog -timescale 1ns/1ns counter.v
vsim counter
log {/*}
add wave {/*}

#first test case
force {KEY[0]} 0 0, 1 1, 0 2, 1 3, 0 4, 1 5, 0 6, 1 7, 0 8, 1 9, 0 10
force {SW[1]} 1
force {SW[0]} 1 0, 0 2, 1 3
run 10ns
