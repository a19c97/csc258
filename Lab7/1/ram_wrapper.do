 vlib work
vlog -timescale 1ns/1ns ram32x4.v
vsim -L altera_mf_ver ram_wrapper
log {/*}
add wave {/*}

force {KEY[0]} 0 0, 1 1 -repeat 2
force {SW[9]} 1 0, 0 4
force {SW[8:4]} 00001 0, 00010 2, 00001 4, 00010 6
force {SW[3:0]} 1111 0, 0001 2
run 0.02ns
