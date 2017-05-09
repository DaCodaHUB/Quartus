onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/Fred_testbench/SW[2]}
add wave -noupdate {/Fred_testbench/SW[1]}
add wave -noupdate {/Fred_testbench/SW[0]}
add wave -noupdate {/Fred_testbench/SW[3]}
add wave -noupdate {/Fred_testbench/LEDR[1]}
add wave -noupdate {/Fred_testbench/LEDR[0]}
add wave -noupdate -expand /Fred_testbench/HEX0
add wave -noupdate -expand /Fred_testbench/HEX1
add wave -noupdate -expand /Fred_testbench/HEX2
add wave -noupdate -expand /Fred_testbench/HEX3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {351 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {935 ps}
