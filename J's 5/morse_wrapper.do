vlib work

vlog -timescale 1ns/1ns morse_wrapper.v

vsim morse_wrapper

log {/*}

add wave {/*}

#frist test

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[1]} 1 0, 0 4, 1 6
force {CLOCK_50} 1
force {KEY[0]} 1 0, 0 1, 1 2

force {CLOCK_50} 0 0, 1 1 -repeat 2

run 100ns
