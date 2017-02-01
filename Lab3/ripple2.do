vlib work
vlog -timescale 1ns/1ns ripple.v
vsim ripple
log {/*}
add wave {/*}

#first test case
# a = 0000, b = 0000, cin = 1
# expected: 0 0001
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 1
run 10ns

#second test case
# a = 1100, b = 0011, cin = 1
# expected: 1 0000
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 1
run 10ns
 
