vlib work
vlog -timescale 1ns/1ns rate_divider.v
vsim rate_divider_wrapper
log {/*}
add wave {/*}

force {SW[1]} 0
force {SW[0]} 1
force {SW[2]} 0 0, 1 2, 0 3
// how the hell am I supposed to force the clock?
force {CLOCK_50} 0 0, 1 1 -repeat 50
