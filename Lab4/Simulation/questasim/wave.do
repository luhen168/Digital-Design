onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_equalizer_8band/clk
add wave -noupdate /tb_equalizer_8band/rst
add wave -noupdate /tb_equalizer_8band/ena
add wave -noupdate -format Analog-Step -height 74 -max 9505.0 -min -8719.0 /tb_equalizer_8band/x_in
add wave -noupdate /tb_equalizer_8band/y_out_1
add wave -noupdate /tb_equalizer_8band/y_out_2
add wave -noupdate /tb_equalizer_8band/y_out_3
add wave -noupdate /tb_equalizer_8band/y_out_4
add wave -noupdate /tb_equalizer_8band/y_out_5
add wave -noupdate /tb_equalizer_8band/y_out_6
add wave -noupdate /tb_equalizer_8band/y_out_7
add wave -noupdate /tb_equalizer_8band/y_out_8
add wave -noupdate -format Analog-Step -height 74 -max 58947351.999999985 -min -57099844.0 /tb_equalizer_8band/y_out
add wave -noupdate -max -2147483565.0 -min -2147483635.0 /tb_equalizer_8band/file
add wave -noupdate /tb_equalizer_8band/out_file_fir1
add wave -noupdate /tb_equalizer_8band/out_file_fir2
add wave -noupdate /tb_equalizer_8band/out_file_fir3
add wave -noupdate /tb_equalizer_8band/out_file_fir4
add wave -noupdate /tb_equalizer_8band/out_file_fir5
add wave -noupdate /tb_equalizer_8band/out_file_fir6
add wave -noupdate /tb_equalizer_8band/out_file_fir7
add wave -noupdate /tb_equalizer_8band/out_file_fir8
add wave -noupdate /tb_equalizer_8band/out_file
add wave -noupdate /tb_equalizer_8band/read_file
add wave -noupdate /tb_equalizer_8band/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {534690 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1757184 ns}
