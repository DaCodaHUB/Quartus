onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cyberWar_testbench/CLOCK_50
add wave -noupdate /cyberWar_testbench/HEX0
add wave -noupdate /cyberWar_testbench/HEX1
add wave -noupdate /cyberWar_testbench/SW
add wave -noupdate {/cyberWar_testbench/KEY[0]}
add wave -noupdate -expand /cyberWar_testbench/LEDR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 206
configure wave -valuecolwidth 69
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
WaveRestoreZoom {0 ps} {966 ps}
