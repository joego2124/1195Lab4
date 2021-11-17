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
    MemoryWrite  : out std_logic;
    MemoryDataIn : in std_logic_vector(31 downto 0);
    MemoryDataOut, MemoryAdress: out std_logic_vector(31 downto 0)
  );
end CPU;

architecture Behavioral of CPU is
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
    
    component SignExtend is
      generic (
        INL   : positive := 16;
        OUTL  : positive := 32;
        SHIFT : integer := 0
      );
      Port (
        INPUT  : in std_logic_vector(INL - 1 downto 0);
        OUTPUT : out std_logic_vector(OUTL - 1 downto 0)
      );
    end component SignExtend;

    
    component CPUControl is
      Port (
        INS : in std_logic_vector(31 downto 0);
        CLK, RST : in std_logic := '0';
        PCWriteCond, PCWrite: out std_logic := '0';
        PCSource : out std_logic_vector(1 downto 0) := "00";
        IorD: out std_logic := '0';
        MemWrite : out std_logic := '0';
        MemtoReg : out std_logic_vector(1 downto 0) := "00";
        IRWrite: out std_logic := '0';
        ALUSrcA, ALUA, ALUB, ALUOut: out std_logic := '0';
        ALUSrcB: out std_logic_vector(1 downto 0) := "00";
        ALUOp: out std_logic_vector(3 downto 0) := "0000";
        RegWrite, RegDst: out std_logic := '0';
        SHAMT : out std_logic_vector(4 downto 0);
        SLLV, MemRegEn : out std_logic;
        Load_sel : out std_logic_vector(1 downto 0)
      );
    end component CPUControl;
    
    signal Mem_out : std_logic_vector(31 downto 0);
    
    --control signals
    signal ALUSrcA : std_logic;
    signal ALUSrcB, Load_sel, MemtoReg  : std_logic_vector(1 downto 0);
    signal PC_en, PCWrite, PCWriteCond, ALU_zero, IorD, ALU_of : std_logic;
    signal MemWrite, IRWrite, RegDst, RegWrite, SLLV, MemRegEn : std_logic;
    
    --IF signals
    signal ALU_result, PC_in, PC_out : std_logic_vector(31 downto 0) := (others => '0');
    signal PCSource : std_logic_vector(1 downto 0) := "00";
    signal J_addr : std_logic_vector(31 downto 0);
    signal J_shift_2 : std_logic_vector(27 downto 0);
    
    --Ins reg signals
    signal Ins_out, Mem_reg_out, LUI_EX  : std_logic_vector(31 downto 0);
     
    --Regs signals
    signal W_reg : std_logic_vector(4 downto 0);
    signal W_data, R_data1, R_data2 : std_logic_vector(31 downto 0);
    signal W_data_seg : std_logic_vector(31 downto 0) := (others => '0');
    
    --Reg to ALU intermediate reg signals
    signal Reg_A_out, Reg_B_out : std_logic_vector(31 downto 0);
    signal EN_A, EN_B : std_logic;
    signal Immediate_ex, Immediate_2 : std_logic_vector(31 downto 0);
    
    --ALU signals
    signal ALU_A, ALU_B, ALU_out : std_logic_vector(31 downto 0);
    signal SHAMT, Shift_bits : std_logic_vector(4 downto 0);
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
            MemWrite => MemoryWrite, MemtoReg => MemtoReg,
            IRWrite => IRWrite,
            ALUSrcA => ALUSrcA, ALUA => EN_A, ALUB => EN_B, ALUOut => ALU_out_en,
            ALUSrcB => ALUSrcB,
            ALUOp => ALUop,
            RegWrite => RegWrite, RegDst => RegDst,
            SHAMT => SHAMT,
            SLLV => SLLV,
            MemRegEn => MemRegEn,
            Load_sel => Load_sel
        );
        
    J_EXT : SignExtend
        generic map (
            INL   => 26,
            OUTL  => 28,
            SHIFT => 2
        )
        Port map (
            INPUT  => Ins_out(25 downto 0),
            OUTPUT => J_shift_2 
        ); 
    
    J_addr(31 downto 28) <= PC_out(31 downto 28); 
    J_addr(27 downto 0) <= J_shift_2;
    
    PC_in <= ALU_result when (PCSource = "00") else
             ALU_out when (PCSource = "01") else
             J_addr when (PCSource = "10") else 
             Reg_A_out;
             
    PC_en <= PCWrite or (PCWriteCond and ALU_zero);
    
    Mem_out <= PC_out when (IorD = '0') else ALU_out;
    MemoryAdress <= Mem_out;
    
    PC_REG : flipflop
        generic map(N => 32)
        port map(
            CLK => Clock,
            D => PC_in,
            EN => PC_en,
            RST => Reset,
            Q => PC_out
        );
        
    INS_REG : flipflop
        generic map (N => 32)
        port map (
            CLK => clock,
            D => MemoryDataIn,
            EN => IRWrite,
            RST => Reset,
            Q => Ins_out
        );
    
    MEM_REG : flipflop
        generic map (N => 32)
        port map (
            CLK => clock,
            D => MemoryDataIn,
            EN => MemRegEn,
            RST => Reset,
            Q => Mem_reg_out
        );
        
    W_reg <= Ins_out(20 downto 16) when (RegDst = '0') else Ins_out(15 downto 11); 
    
    W_data <= ALU_Out when (MemtoReg = "00") else 
              W_data_seg when (MemtoReg = "01") else
              LUI_EX; 
    
    process(Mem_reg_out)
    begin
        W_data_seg <= x"00000000";
        if (Load_sel = "00") then
            W_data_seg <= Mem_reg_out; --load word
        elsif (Load_sel = "01") then
            if (Mem_out(1) = '1') then
                W_data_seg(15 downto 0) <= Mem_reg_out(31 downto 16); --load upper halfword
            else
                W_data_seg(15 downto 0) <= Mem_reg_out(15 downto 0); --load lower halfword
            end if;
        elsif (Load_sel = "10") then
            if (Mem_out(1 downto 0) = "11") then
                W_data_seg(7 downto 0) <= Mem_reg_out(31 downto 24); --load highest byte
            elsif (Mem_out(1 downto 0) = "10") then
                W_data_seg(7 downto 0) <= Mem_reg_out(23 downto 16); --load upper mid byte
            elsif (Mem_out(1 downto 0) = "01") then
                W_data_seg(7 downto 0) <= Mem_reg_out(15 downto 8); --load lower mid byte
            else
                W_data_seg(7 downto 0) <= Mem_reg_out(7 downto 0); --load lowest byte
            end if;
        end if;
    end process;
    
    LUI : SignExtend
        generic map (
            INL   => 16,
            OUTL  => 32,
            SHIFT => 16
        )
        Port map (
            INPUT  => Ins_out(15 downto 0),
            OUTPUT => LUI_EX
        ); 
    
    IMM_EX : SignExtend
        generic map (
            INL   => 16,
            OUTL  => 32,
            SHIFT => 0
        )
        Port map (
            INPUT  => Ins_out(15 downto 0),
            OUTPUT => Immediate_ex
        );
        
    IMM_2 : SignExtend
        generic map (
            INL   => 32,
            OUTL  => 32,
            SHIFT => 2
        )
        Port map (
            INPUT  => Immediate_ex,
            OUTPUT => Immediate_2
        );    
    
    REGS : Registers
        port map (
            CLK => Clock,
            RST => '0',
            EN => RegWrite,
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
    
    MemoryDataOut <= Reg_B_out;
        
    ALU_A <= PC_out when (ALUSrcA = '0') else Reg_A_out;
    
    ALU_B <= Reg_B_out when (ALUSrcB = "00") else
             x"00000004" when (ALUSrcB = "01") else
             Immediate_ex when (ALUSrcB = "10") else
             Immediate_2; 
    
    Shift_bits <= SHAMT when (SLLV = '0') else Reg_A_out(4 downto 0);
    
    ALU_Block : ALU
        port map (
            A => ALU_A,
            B => ALU_B,
            SHAMT => Shift_bits,
            ALUop => ALUop,
            R =>  ALU_result,
            Overflow => ALU_of,
            Zero => ALU_zero
        );
    
    ALU_Reg : flipflop
        generic map (N => 32)
        port map (
            CLK => clock,
            D => ALU_result,
            EN => ALU_out_en,
            RST => Reset,
            Q => ALU_out
        );
    
    
end Behavioral;
