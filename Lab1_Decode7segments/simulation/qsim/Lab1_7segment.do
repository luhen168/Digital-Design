onerror {quit -f}
vlib work
vlog -work work Lab1_7segment.vo
vlog -work work Lab1_7segment.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.top_7segment_vlg_vec_tst
vcd file -direction Lab1_7segment.msim.vcd
vcd add -internal top_7segment_vlg_vec_tst/*
vcd add -internal top_7segment_vlg_vec_tst/i1/*
add wave /*
run -all
