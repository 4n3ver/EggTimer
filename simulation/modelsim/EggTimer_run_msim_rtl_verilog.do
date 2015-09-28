transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Dropbox/Documents/University/CS\ 3220/Assignment/Real\ Project\ 1\ -\ Egg\ Timer {E:/Dropbox/Documents/University/CS 3220/Assignment/Real Project 1 - Egg Timer/OnBoard.v}

