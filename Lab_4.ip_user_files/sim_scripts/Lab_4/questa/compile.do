vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_4
vlib questa_lib/msim/processing_system7_vip_v1_0_6
vlib questa_lib/msim/generic_baseblocks_v2_1_0
vlib questa_lib/msim/axi_register_slice_v2_1_18
vlib questa_lib/msim/fifo_generator_v13_2_3
vlib questa_lib/msim/axi_data_fifo_v2_1_17
vlib questa_lib/msim/axi_crossbar_v2_1_19
vlib questa_lib/msim/lib_cdc_v1_0_2
vlib questa_lib/msim/proc_sys_reset_v5_0_13
vlib questa_lib/msim/blk_mem_gen_v8_4_2
vlib questa_lib/msim/blk_mem_gen_v8_3_6
vlib questa_lib/msim/axi_bram_ctrl_v4_1_0
vlib questa_lib/msim/xlconstant_v1_1_5
vlib questa_lib/msim/xlconcat_v2_1_1
vlib questa_lib/msim/axi_protocol_converter_v2_1_18

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_4 questa_lib/msim/axi_vip_v1_1_4
vmap processing_system7_vip_v1_0_6 questa_lib/msim/processing_system7_vip_v1_0_6
vmap generic_baseblocks_v2_1_0 questa_lib/msim/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_18 questa_lib/msim/axi_register_slice_v2_1_18
vmap fifo_generator_v13_2_3 questa_lib/msim/fifo_generator_v13_2_3
vmap axi_data_fifo_v2_1_17 questa_lib/msim/axi_data_fifo_v2_1_17
vmap axi_crossbar_v2_1_19 questa_lib/msim/axi_crossbar_v2_1_19
vmap lib_cdc_v1_0_2 questa_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 questa_lib/msim/proc_sys_reset_v5_0_13
vmap blk_mem_gen_v8_4_2 questa_lib/msim/blk_mem_gen_v8_4_2
vmap blk_mem_gen_v8_3_6 questa_lib/msim/blk_mem_gen_v8_3_6
vmap axi_bram_ctrl_v4_1_0 questa_lib/msim/axi_bram_ctrl_v4_1_0
vmap xlconstant_v1_1_5 questa_lib/msim/xlconstant_v1_1_5
vmap xlconcat_v2_1_1 questa_lib/msim/xlconcat_v2_1_1
vmap axi_protocol_converter_v2_1_18 questa_lib/msim/axi_protocol_converter_v2_1_18

vlog -work xilinx_vip -64 -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L xilinx_vip "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib -64 -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L xilinx_vip "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/5a01/src/mm_regmap.vhd" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/5a01/src/axi_regmap.vhd" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_axi_regmap_0_0/sim/Lab_4_axi_regmap_0_0.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_4 -64 -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L xilinx_vip "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/98af/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_6 -64 -sv -L axi_vip_v1_1_4 -L processing_system7_vip_v1_0_6 -L xilinx_vip "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0/sim/Lab_4_processing_system7_0_0.v" \

vlog -work generic_baseblocks_v2_1_0 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_18 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/cc23/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_3 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/64f4/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_3 -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_3 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_17 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/c4fd/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_19 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/6c9d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_xbar_0/sim/Lab_4_xbar_0.v" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_rst_ps7_0_100M_0/sim/Lab_4_rst_ps7_0_100M_0.vhd" \

vlog -work blk_mem_gen_v8_4_2 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/37c2/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_blk_mem_gen_0_0/sim/Lab_4_blk_mem_gen_0_0.v" \

vlog -work blk_mem_gen_v8_3_6 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/2751/simulation/blk_mem_gen_v8_3.v" \

vcom -work axi_bram_ctrl_v4_1_0 -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/27fe/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_axi_bram_ctrl_0_0/sim/Lab_4_axi_bram_ctrl_0_0.vhd" \

vlog -work xlconstant_v1_1_5 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/4649/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_xlconstant_0_0/sim/Lab_4_xlconstant_0_0.v" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_CPU_0_0/sim/Lab_4_CPU_0_0.v" \

vlog -work xlconcat_v2_1_1 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_xlconcat_0_0/sim/Lab_4_xlconcat_0_0.v" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/sim/Lab_4.v" \

vlog -work axi_protocol_converter_v2_1_18 -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/7a04/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/ec67/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ipshared/70cf/hdl" "+incdir+../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_auto_pc_0/sim/Lab_4_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

