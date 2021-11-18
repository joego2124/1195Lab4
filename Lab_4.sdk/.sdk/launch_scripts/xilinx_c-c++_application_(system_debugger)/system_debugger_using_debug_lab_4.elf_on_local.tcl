connect -url tcp:127.0.0.1:3121
source C:/Xilinx/Lab_4/Lab_4.sdk/Lab_4_wrapper_hw_platform_0/ps7_init.tcl
targets -set -filter {jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A8B9E9A" && level==0} -index 1
fpga -file C:/Xilinx/Lab_4/Lab_4.sdk/Lab_4_wrapper_hw_platform_0/Lab_4_wrapper.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A8B9E9A"} -index 0
loadhw -hw C:/Xilinx/Lab_4/Lab_4.sdk/Lab_4_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A8B9E9A"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A8B9E9A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A8B9E9A"} -index 0
dow C:/Xilinx/Lab_4/Lab_4.sdk/Lab_4/Debug/Lab_4.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A8B9E9A"} -index 0
con
