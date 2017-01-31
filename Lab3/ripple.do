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

#second test case
# a = 0001, b = 0001, cin = 0
# expected: 0010 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1
force {SW[8]} 0
run 10ns

#first test case
# a = 1111, b = 0001, cin = 0
# expected: 0000 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1
force {SW[8]} 0
run 10ns
