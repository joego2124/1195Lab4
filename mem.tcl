# restart the simulation
restart

add_force {mw_U_0ram_table[0]} -radix hex {20070011}
add_force {mw_U_0ram_table[1]} -radix hex {200BFFFD}
add_force {mw_U_0ram_table[2]} -radix hex {00EB5824}
add_force {mw_U_0ram_table[3]} -radix hex {ACEB000F}

add_force addr -radix hex 0

#forcing a clock with 10 ns period
add_force clk 1 {0 5ns} -repeat_every 10ns

run 200 ns