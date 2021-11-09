----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2021 11:39:24 AM
-- Design Name: 
-- Module Name: CPU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
  Port (
    Reset, Clock : in std_logic;
    MemoryDataIn : in std_logic_vector(31 downto 0);
    MemoryDataOut, MemoryAdress, MemoryWrite: out std_logic_vector(31 downto 0)
  );
end CPU;

architecture Behavioral of CPU is
    signal PC : std_logic_vector(31 downto 0);
    
    component flipflop is
        generic (N : positive := 64);
        Port (
            CLK : in std_logic;
            D   : in std_logic_vector(N - 1 downto 0);
            EN  : in std_logic;
            RST : in std_logic;
            Q   : out std_logic_vector(N - 1 downto 0)
        );
    end component flipflop;
    
    component Registers is
      Port (
        CLK, RST, EN : in std_logic;
        IN1, IN2, W : in std_logic_vector(4 downto 0);
        D : in std_logic_vector(31 downto 0);
        OUT1, OUT2 : out std_logic_vector(31 downto 0)
      );
    end component Registers;
    
    component ALU is
      Port (
        A, B            : in std_logic_vector(31 downto 0);
        SHAMT           : in std_logic_vector(4 downto 0);
        ALUop           : in std_logic_vector(3 downto 0);
        R               : out std_logic_vector(31 downto 0);
        Overflow, Zero  : out std_logic
      );
    end component ALU;

    
    component CPUControl is
      Port (
        INS : in std_logic_vector(31 downto 0);
        CLK, RST : in std_logic := '0';
        PCWriteCond, PCWrite: out std_logic := '0';
        PCSource : out std_logic_vector(1 downto 0) := "00";
        IorD: out std_logic := '0';
        MemWrite, MemtoReg: out std_logic := '0';
        IRWrite: out std_logic := '0';
        ALUSrcA, ALUA, ALUB, ALUOut: out std_logic := '0';
        ALUSrcB: out std_logic_vector(1 downto 0) := "00";
        ALUOp: out std_logic_vector(3 downto 0) := "0000";
        RegWrite, RegDst: out std_logic := '0'
      );
    end component CPUControl;
    
    --control signals
    signal ALUSrcA : std_logic;
    signal ALUSrcB : std_logic_vector(1 downto 0);
    signal PC_en, PCWrite, PCWriteCond, ALU_zero, IorD, ALU_of : std_logic;
    signal MemWrite, MemtoReg, IRWrite, RegDst, RegWrite : std_logic;
    
    --IF signals
    signal ALU_result, top_shiftL2, PC_in, PC_out : std_logic_vector(31 downto 0);
    signal PCSource : std_logic_vector(1 downto 0) := "00";
    
    --Ins reg signals
    signal Ins_out : std_logic_vector(31 downto 0);
     
    --Regs signals
    signal R_Reg1, R_Reg2, W_reg : std_logic_vector(4 downto 0);
    signal W_data, R_data1, R_data2 : std_logic_vector(31 downto 0);
    signal W_en : std_logic;
    
    --Reg to ALU intermediate reg signals
    signal Reg_A_out, Reg_B_out : std_logic_vector(31 downto 0);
    signal EN_A, EN_B : std_logic;
    
    --ALU signals
    signal ALU_A, ALU_B, ALU_out : std_logic_vector(31 downto 0);
    signal SHAMT : std_logic_vector(4 downto 0);
    signal ALUop : std_logic_vector(3 downto 0);
    signal ALU_out_en : std_logic;
    
begin

    CONTROL : CPUControl
        port map (
            CLK => Clock, RST => Reset,
            INS => Ins_out,
            PCWriteCond => PCWriteCond, PCWrite => PCWrite,
            PCSource => PCSource,
            IorD => IorD,
            MemWrite => MemWrite, MemtoReg => MemtoReg,
            IRWrite => IRWrite,
            ALUSrcA => ALUSrcA, ALUA => EN_A, ALUB => EN_B, ALUOut => ALU_out_en,
            ALUSrcB => ALUSrcB,
            ALUOp => ALUop,
            RegWrite => RegWrite, RegDst => RegDst
        );
    
    PC_in <= ALU_result when (PCSource = "00") else
             ALU_out when (PCSource = "01") else
             top_shiftL2;
             
    PC_en <= PCWrite or (PCWriteCond and ALU_zero);
    
    MemoryAdress <= PC_out when (IorD = '0') else ALU_out;
    
    PC_REG : flipflop
        generic map(N => 32)
        port map(
            CLK => Clock,
            D => PC_in,
            EN => PC_en,
            RST => '0',
            Q => PC_out
        );
        
    INS_REG : flipflop
        generic map (N => 32)
        port map (
            CLK => clock,
            D => MemoryDataIn,
            EN => MemWrite,
            RST => '0',
            Q => Ins_out
        );
    
    W_reg <= Ins_out(20 downto 16) when (RegDst = '0') else Ins_out(15 downto 11); 
    
    W_data <= ALU_Out; --temp
    
    REGS : Registers
        port map (
            CLK => Clock,
            RST => '0',
            EN => W_en,
            W => W_reg,
            IN1 => Ins_out(25 downto 21),
            IN2 => Ins_out(20 downto 16),
            D => W_data,
            OUT1 => R_data1,
            OUT2 => R_data2
        ); 
    
    REG_A : flipflop
        generic map (N => 32)
        port map (
            CLK => clock,
            D => R_data1,
            EN => EN_A,
            RST => Reset,
            Q => Reg_A_out
        );

    REG_B : flipflop
        generic map (N => 32)
        port map (
            CLK => clock,
            D => R_data2,
            EN => EN_B,
            RST => Reset,
            Q => Reg_B_out
        );
        
    ALU_A <= PC_out when (ALUSrcA = '0') else Reg_A_out;
    
    ALU_B <= Reg_B_out when (ALUSrcB = "00") else x"00000004"; --add to
    
    ALU_Block : ALU
        port map (
            A => ALU_A,
            B => ALU_B,
            SHAMT => SHAMT,
            ALUop => ALUop,
            R =>  ALU_result,
            Overflow => ALU_of,
            Zero => ALU_zero
        );

end Behavioral;
