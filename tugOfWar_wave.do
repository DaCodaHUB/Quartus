onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tugOfWar_testbench/CLOCK_50
add wave -noupdate -expand /tugOfWar_testbench/HEX0
add wave -noupdate {/tugOfWar_testbench/KEY[3]}
add wave -noupdate {/tugOfWar_testbench/KEY[0]}
add wave -noupdate {/tugOfWar_testbench/SW[9]}
add wave -noupdate {/tugOfWar_testbench/LEDR[9]}
add wave -noupdate {/tugOfWar_testbench/LEDR[8]}
add wave -noupdate {/tugOfWar_testbench/LEDR[7]}
add wave -noupdate {/tugOfWar_testbench/LEDR[6]}
add wave -noupdate {/tugOfWar_testbench/LEDR[5]}
add wave -noupdate {/tugOfWar_testbench/LEDR[4]}
add wave -noupdate {/tugOfWar_testbench/LEDR[3]}
add wave -noupdate {/tugOfWar_testbench/LEDR[2]}
add wave -noupdate {/tugOfWar_testbench/LEDR[1]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 224
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {854 ps}
