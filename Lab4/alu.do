vlib work
vlog -timescale 1ns/1ns alu.v
vsim alu
log {/*}
add wave {/*}

# first test case
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {KEY[0]} 1
force {SW[7]} 1
force {SW[8]} 1
force {SW[9]} 0

# second test case
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {KEY[0]} 1
force {SW[7]} 1
force {SW[8]} 1
force {SW[9]} 0

# third test case
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {KEY[0]} 1
force {SW[7]} 1
force {SW[8]} 1
force {SW[9]} 0

# fourth test case
# clock off - should be all 0 output?
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {KEY[0]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0

# fifth test case
# clock on - control for test four
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {KEY[0]} 1
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
