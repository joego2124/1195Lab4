restart

# addi $7, $0, 17 
# addi $11, $0, -3 
# bne $11, $7, 0x7
# addi $1, $0, 2 

# sll $0, $0, 0  
# sll $0, $0, 0 
# addi $1, $0, 1 
# sw $1, 15($7) 
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {15670007}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {20010002}

add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[4]} -radix hex {00000000}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[5]} -radix hex {00000000}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[6]} -radix hex {20010001}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[7]} -radix hex {ACE1000F}

add_force clk 1 {0 5ns} -repeat_every 10ns

run 350 ns