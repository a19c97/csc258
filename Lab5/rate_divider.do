vlib work
vlog -timescale 1ns/1ns rate_divider.v
vsim rate_divider_wrapper
log {/*}
add wave {/*}

force {SW[1]} 0
force {SW[0]} 0
force {SW[2]} 0 0, 1 2, 0 3
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 100ns
