vlib work
vlog -timescale 1ns/1ns sample.v
vsim fpga_top
log {/*}
add wave {/*}

force {KEY[0]} 0 0, 1 4 
force {KEY[1]} 1 0, 0 7, 1 9, 0 11, 1 13, 0 15, 1 17, 0 19, 1 21
force {SW[7:0]} 00000000 0, 00000001 6, 00000000 10, 00000001 14, 00000000 18
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 36ns
