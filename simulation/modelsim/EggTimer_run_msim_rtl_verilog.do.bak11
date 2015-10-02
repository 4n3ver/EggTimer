transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Dropbox/Documents/University/CS\ 3220/Assignment/Real\ Project\ 1\ -\ Egg\ Timer {E:/Dropbox/Documents/University/CS 3220/Assignment/Real Project 1 - Egg Timer/ClockDiviver.v}

vlog -vlog01compat -work work +incdir+E:/Dropbox/Documents/University/CS\ 3220/Assignment/Real\ Project\ 1\ -\ Egg\ Timer {E:/Dropbox/Documents/University/CS 3220/Assignment/Real Project 1 - Egg Timer/ClockDiviverTester.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  ClockDividerTester

add wave *
view structure
view signals
run -all
