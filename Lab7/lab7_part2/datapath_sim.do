vlib work
vlog -timescale 1ns/1ns part2.v
vsim datapath
log {/*}
add wave {/*}

force {clk} 0 0, 1 1 -repeat 2
force {data_in} 0000000 0, 0000001 6, 000100 10
force {ld_x} 0 0, 1 7, 0 9
force {ld_y} 0 0, 1 11, 0 13
force {incr} 0 0, 1 1 -repeat 2