vlib work
vlog -timescale 1ns/1ns alu.v
vsim alu
log {/*}
add wave {/*}

#first test case
#concat 0000 and 0000
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
run 10ns

#second test case
#concat 1100 and 0011
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 1
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
run 10ns

#third test case
#redor 0001 0000
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
run 10ns

#fourth test case
#redor 0000 0000
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
run 10ns

#fifth test case
#op3 0000 0000 -> 00000000
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
run 10ns

#sixth test case
#op3 0110 0110 -> ?
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
run 10ns

#seventh test case
#vadder 1000 0001 -> 00001001
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
run 10ns

#eighth test case
#op3 0111 0001 -> 00001000
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
run 10ns
