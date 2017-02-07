vlib work
vlog -timescale 1ns/1ns shifter.v
vsim shifter
log {/*}
add wave {/*}

# first test case
# all 1's, shifting right, with ASR
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[9]} 1
#force {KEY[0]} 0
force {KEY[0]} 0 0, 1 1, 0 2, 1 3, 0 4, 1 5, 0 6, 1 7, 0 8, 1 9, 0 10
force {KEY[1]} 0 0, 1 2
force {KEY[2]} 1
force {KEY[3]} 0
run 10ns

