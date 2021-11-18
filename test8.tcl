restart

# lui $1, 0x00001001
# ori $13, $1,0x00000020 
# lui $1, 0x0x00000123 
# ori $9, $1,0x00004567 

# sw $9, 0($13) 
# lh $11, 2($13) 
# sw $11, 16($13) 
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {3C011001}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {342D0020}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {3C010123}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {34294567}

add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[4]} -radix hex {ADA90000}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[5]} -radix hex {85AB0002}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[6]} -radix hex {ADAB0010}

add_force clk 1 {0 5ns} -repeat_every 10ns

run 500 ns