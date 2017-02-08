vlib work
vlog -timescale 1ns/1ns alu.v
vsim alu
log {/*}
add wave {/*}

#force {KEY[0]} 1 0, 0 1, 1 2, 0 3, 1 4, 0 5 
#force {SW[9]} 0 0, 1 2 

# first test case
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {KEY[0]} 1 0, 0 1, 1 2, 0 3, 1 4, 0 5, 1 6, 0 7, 1 8, 0 9, 1 10
force {SW[9]}  1 0, 0 3
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 10ns

