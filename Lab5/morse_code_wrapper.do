vlib work
vlog -timescale 1ns/1ns morse_code.v
vsim morse_code_wrapper
log {/*}
add wave {/*}

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {KEY[1]} 0 0, 1 1 
force {KEY[0]} 1 
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 10ns
