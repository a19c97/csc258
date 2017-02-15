vlib work
vlog -timescale 1ns/1ns morse_code.v
vsim morse_code
log {/*}
add wave {/*}

force {s} 000
force {start} 0 0, 1 1 
force {reset} 1 
force {clock} 0 0, 1 1 -repeat 2
run 10ns
