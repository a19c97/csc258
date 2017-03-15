vlib work
vlog -timescale 1ns/1ns part2_alternative.v
vsim datapath
log {/*}
add wave {/*}

force {clk} 0 0, 1 1 -repeat 2
force {resetn} 1 0, 0 1, 1 3
force {data_in} 0000000 0, 0000011 6, 000000 10
force {ld_x} 0 0, 1 7, 0 10
force {ld_y} 0 0, 1 11, 0 14
force {incr} 0 0, 1 15
run 50ns
