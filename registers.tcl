restart

add_force D -radix hex 00000001
add_force W -radix hex 1F
add_force IN1 -radix hex 1F

add_force EN 1
add_force RST 0

add_force CLK 1
run 10 ns 
add_force CLK 0
run 10 ns 

add_force D -radix hex 00000002
add_force W -radix hex 1E
add_force IN2 -radix hex 1E

if {[get_value -radix unsigned OUT1] == [expr {0x00000001}]} {
	puts "Correct! Load"
} else {
	puts "Wrong! Load"
}

add_force CLK 1
run 10 ns 
add_force CLK 0
run 10 ns 

if {[get_value -radix unsigned OUT2] == [expr {0x00000002}]} {
	puts "Correct! Load 2"
} else {
	puts "Wrong! Load 2"
}
