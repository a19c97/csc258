vlib work
vlog -timescale 1ns/1ns morse_code.v
vsim select_letter
log {/*}
add wave {/*}

force {s} 000
run 5ns
