vlib work
vlog -timescale 1ns/1ns poly_functions.v
vsim fpga_top
log {/*}
add wave {/*}

#first test case
# A = 00000011, B = 00000000, C = 00000111, x = 00000001
# Expected output: 00001001
force {KEY[0]} 0 0, 1 4 
force {KEY[1]} 0 0, 1 7, 0 8, 1 9, 0 10, 1 11, 0 12, 1 13, 0 14 
force {SW[0]} 0 0, 1 6, 0 8, 1 10, 1 12
force {SW[1]} 0 0, 1 6, 0 8, 1 10, 0 12
force {SW[2]} 0 0, 0 6, 0 8, 1 10, 0 12
force {SW[3]} 0 0, 0 6, 0 8, 0 10, 0 12
force {SW[4]} 0 0, 0 6, 0 8, 0 10, 0 12
force {SW[5]} 0 0, 0 6, 0 8, 0 10, 0 12
force {SW[6]} 0 0, 0 6, 0 8, 0 10, 0 12
force {SW[7]} 0 0, 0 6, 0 8, 0 10, 0 12
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 20ns
