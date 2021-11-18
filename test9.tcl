restart

# lui $1, 0x00001001 
# ori $13, $1,0x00000020 
# addi $9, $0,-45 

# clo, $10,$9 
# sw $10, 0($13) 
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {3C011001}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {342D0020}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {2009FFD3}

add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {71205021}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[4]} -radix hex {ADAA0000}

add_force clk 1 {0 5ns} -repeat_every 10ns

run 350 ns