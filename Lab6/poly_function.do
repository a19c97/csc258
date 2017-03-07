vlib work
vlog -timescale 1ns/1ns poly_function.v
vsim fpga_top
log {/*}
add wave {/*}

#first test case
# A = 00000011, B = 00000001, C = 00000111, x = 00000001
# Expected output: 00001011
force {KEY[0]} 0 0, 1 4 
#force {KEY[1]} 1 0, 0 7, 1 8, 0 11, 1 12, 0 15, 1 16, 0 19, 1 20
force {KEY[1]} 1 0, 0 7, 1 9, 0 11, 1 13, 0 15, 1 17, 0 19, 1 21, 0 23, 1 25
force {SW[7:0]} 00000000 0, 00000011 6, 00000000 10, 00000010 14, 00000010 18
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 36ns
