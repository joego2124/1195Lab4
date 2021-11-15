# restart the simulation
restart

# Forcing a program (instruction memory)
#addi $7, $0, 17
#addi $11, $0, -3
#and $11, $7, $11
#sw $11, 15($7)

add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {00EB5824}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {ACEB000F}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[4]} -radix hex {84E0000F}

#forcing a clock with 10 ns period
add_force clk 1 {0 5ns} -repeat_every 10ns



run 250 ns