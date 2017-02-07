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
#force {KEY[0]} 1 0, 0 1, 1 2, 0 3, 1 4, 0 5 
#force {SW[9]} 0 0, 1 2 
force {KEY[0]} 1
force {SW[9]} 0
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# second test case
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {KEY[0]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# third test case
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {KEY[0]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# fourth test case
# clock off - should be all 0 output?
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {KEY[0]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 10ns

# fifth test case
# clock on - control for test four
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {KEY[0]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 10ns
