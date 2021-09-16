transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/Snooping.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/MaquinaDeEstados.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/MaquinaDeEstadosOuvinte.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/cache.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/upcount.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/MemInst.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/memRam.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/counter.v}

vlog -vlog01compat -work work +incdir+C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4 {C:/Users/alexa/Documents/Repositorios/LAOC-2/Praticas/Pratica4/simula.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  simula

add wave *
view structure
view signals
run -all
