vlib work
vlog -timescale 1ns/1ns part2_alternative.v
vsim control
log {/*}
add wave {/*}

force {clk} 0 0, 1 1 -repeat 2
force {resetn} 1 0, 0 1, 1 4
force {load} 0 0, 1 5, 0 7, 1 9, 0 11
force {go} 0 0, 1 17
force {finished_drawing} 1 0, 0 19, 1 25, 0 27
run 56ns
