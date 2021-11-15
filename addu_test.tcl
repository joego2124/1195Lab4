restart

# 10 ns period
add_force {/CPU/Clock} -radix hex {0 0ns} {1 5000ps} -repeat_every 10000ps



# Use registers 0 and 1, store into 3, and perform ADDU:
add_force MemoryDataIn -radix hex 201821

run 80 ns

remove_forces -all