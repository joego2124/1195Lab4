restart

# addi $7, $0, 17 
# addi $11, $0, -3 
# sllv $11, $7, $7 
# sw $11, 15($7) 
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {00E75804}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {ACEB000F}

add_force clk 1 {0 5ns} -repeat_every 10ns

run 250 ns