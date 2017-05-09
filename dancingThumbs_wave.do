onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dancingThumbs_testbench/CLOCK_50
add wave -noupdate {/dancingThumbs_testbench/SW[9]}
add wave -noupdate {/dancingThumbs_testbench/KEY[0]}
add wave -noupdate /dancingThumbs_testbench/HEX0
add wave -noupdate /dancingThumbs_testbench/HEX1
add wave -noupdate /dancingThumbs_testbench/dut/c1/point
add wave -noupdate /dancingThumbs_testbench/dut/c2/point
add wave -noupdate /dancingThumbs_testbench/dut/c3/point
add wave -noupdate /dancingThumbs_testbench/dut/c4/point
add wave -noupdate /dancingThumbs_testbench/dut/c1/column
add wave -noupdate -expand /dancingThumbs_testbench/LEDR
add wave -noupdate /dancingThumbs_testbench/dut/s1/out
add wave -noupdate /dancingThumbs_testbench/dut/s2/out
add wave -noupdate /dancingThumbs_testbench/dut/s3/out
add wave -noupdate /dancingThumbs_testbench/dut/s4/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {48 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
configure wave -valuecolwidth 99
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {926 ps}
