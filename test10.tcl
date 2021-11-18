restart

# lui $1, 0x00001001 
# ori $3, $0, 0xFF0F 
# sw $3, 32($1) 
# ori $5, $0, 0xBBBB 

# sll $0,$0,0 
# lw $2, 32($1) 
# and $4, $2,$5 
# sw $4, 36($1)
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {3C011001}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {3403FF0F}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {AC230020}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {3405BBBB}

add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[4]} -radix hex {00000000}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[5]} -radix hex {8C220020}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[6]} -radix hex {00452024}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[7]} -radix hex {AC240024}

add_force clk 1 {0 5ns} -repeat_every 10ns

run 350 ns