vlib work
vlog -timescale 1ns/1ns fourmux.v
vsim fourmux
log {/*}
add wave {/*}

#first test case
# s0s1 = 00 -> u
# expected: 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10ns

#second test case
# s0s1 = 01
# expected: 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 0
run 10ns

#third test case
# s0s1 = 10 -> v
# expected: 1
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 0
run 10ns

#fourth test case
# s0s1 = 01 -> w
# expected: 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 1
run 10ns

#fifth test case
# s0s1 = 11 -> x
# expected: 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[8]} 1
force {SW[9]} 1
run 10ns
