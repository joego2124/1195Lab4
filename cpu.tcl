restart

add_force RegWrite 1
add_force W_reg  -radix hex 00
add_force W_data  -radix hex 00000001

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force W_reg  -radix hex 01
add_force W_data  -radix hex 00000002

add_force MemoryDataIn -radix hex 11021
add_force Reset 0

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

remove_forces -all

add_force MemoryDataIn -radix hex 8C40000F

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 

add_force clock 1
run 10 ns 
add_force clock 0
run 10 ns 