// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Thu Nov 18 02:30:59 2021
// Host        : DESKTOP-0NACQ70 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Xilinx/Lab_4/Lab_4.srcs/sources_1/bd/Lab_4/ip/Lab_4_CPU_0_0/Lab_4_CPU_0_0_stub.v
// Design      : Lab_4_CPU_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "CPU,Vivado 2018.3" *)
module Lab_4_CPU_0_0(Reset, Clock, MemoryWrite, MemoryDataIn, 
  MemoryDataOut, MemoryAdress)
/* synthesis syn_black_box black_box_pad_pin="Reset,Clock,MemoryWrite,MemoryDataIn[31:0],MemoryDataOut[31:0],MemoryAdress[31:0]" */;
  input Reset;
  input Clock;
  output MemoryWrite;
  input [31:0]MemoryDataIn;
  output [31:0]MemoryDataOut;
  output [31:0]MemoryAdress;
endmodule
