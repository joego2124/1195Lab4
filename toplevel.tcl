# restart the simulation
restart

# Forcing a program (instruction memory)
#addi $7, $0, 17
#addi $11, $0, -3
#and $11, $7, $11
#sw $11, 48($24)

# add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {2007FFFF}
# add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {200BFFFD}
# add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {00EB5824}
# add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {AF0B0030}

# lui  $3, 123
# addi $3, $3, 4567 
# sw   $3, 48($24)
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[0]} -radix hex {3C030123}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[1]} -radix hex {20634567}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[2]} -radix hex {AF030030}

#lw 0, $12(48)
#lh 1, $12(50)
#lb 2, $12(48)
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[3]} -radix hex {8F000030}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[4]} -radix hex {87010032}
add_force {/cpu_tb/CPU_mem/mw_U_0ram_table[5]} -radix hex {83020030}

#forcing a clock with 10 ns period
add_force clk 1 {0 5ns} -repeat_every 10ns



run 300 ns