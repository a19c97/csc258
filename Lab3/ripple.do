vlib work
vlog -timescale 1ns/1ns ripple.v
vsim ripple
log {/*}
add wave {/*}

#first test case
# a = 0000, b = 0000, cin = 0
# expected: 0000 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns
