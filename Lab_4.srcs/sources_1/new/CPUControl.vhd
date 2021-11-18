----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2021 11:04:43 AM
-- Design Name: 
-- Module Name: CPUControl - Behavioral
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

entity CPUControl is
  Port (
    INS : in std_logic_vector(31 downto 0);
    CLK, RST, Done : in std_logic := '0';
    PCWriteCond, PCWrite, Mult_reg_sel, HI_en, LO_en, Mult_rst, leading_sel, sign_sel : out std_logic := '0';
    PCSource, MemtoReg : out std_logic_vector(1 downto 0) := "00";
    IorD: out std_logic := '0';
    MemWrite : out std_logic := '0';
    IRWrite: out std_logic := '0';
    ALUSrcA, ALUA, ALUB, ALUOut: out std_logic := '0';
    ALUSrcB: out std_logic_vector(1 downto 0) := "00";
    ALUOp: out std_logic_vector(3 downto 0) := "0000";
    RegWrite, RegDst: out std_logic := '0';
    SHAMT : out std_logic_vector(4 downto 0);
    SLLV, MemRegEn : out std_logic;
    Load_sel : out std_logic_vector(1 downto 0)
  );
end CPUControl;

architecture Behavioral of CPUControl is
    
    type state_type is (
        ins_fetch, 
        ins_decode, 
        exec, 
        r_comp, 
        write_back, 
        branch_comp, 
        jump_comp, 
        mem_access, 
        mem_comp, 
        mem_read_comp, 
        LUI_comp, 
        mult_exec,
        mult_comp,
        clo_comp
    );
    
    signal pr_state, next_state : state_type;
    
    signal OP, FUNC : std_logic_vector(5 downto 0);
begin

    OP <= INS(31 downto 26);
    FUNC <= INS(5 downto 0);
    Load_sel <= "00" when (OP = "100011") else --load word
                "01" when (OP = "100001") else --load half word
                "10"; --load byte

    process (CLK, RST)
    begin
        if (RST = '1') then
            pr_state <= ins_fetch;
        elsif (CLK'event and CLK = '1') then
            pr_state <= next_state;
        end if;
    end process;
    
    process (OP, FUNC, pr_state, Done)
    begin
        case pr_state is
            when ins_fetch =>
                PCWriteCond <= '0'; --disable branch cond
                PCWrite <= '0'; --finished updating PC
                RegWrite <= '0'; --disable writing to registers
                IorD <= '0'; --default to PC reg
                MemWrite <= '0'; --disable memory write
                IRWrite <= '1'; --write instruction to instruction reg
                HI_en <= '0';
                LO_en <= '0';
                leading_sel <= '0';
                sign_sel <= '1';
                next_state <= ins_decode;
            when ins_decode =>
                IRWrite <= '0'; --close instruction register
                
                --R-type
                if (OP = "000000") then 
                    ALUA <= '1'; --latch ALU inputs
                    ALUB <= '1';
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "00"; --set SrcB to regB
                    SLLV <= '0'; --reset SLLV flag
                    next_state <= exec;
                    
                    if (FUNC = "100001") then --ADDU
                        ALUOp <= "0101"; 
                    elsif (FUNC = "100100") then --AND
                        ALUOp <= "0000";
                    elsif (FUNC = "100010") then --SUB
                        ALUOp <= "0110";
                    elsif (FUNC = "000011") then --SRA
                        ALUOp <= "1111";
                        SHAMT <= INS(10 downto 6);
                    elsif (FUNC = "000100") then --SLLV
                        ALUOp <= "1100";
                        SLLV <= '1'; --set SLLV flag
                    elsif (FUNC = "000000") then --SLL
                        ALUOp <= "1100";
                        SHAMT <= INS(10 downto 6);
                    elsif (FUNC = "001000") then --JR
                        next_state <= jump_comp;
                    elsif (FUNC = "011001") then --MULTU
                        Mult_rst <= '1'; --reset multiplier
                        next_state <= mult_exec;
                    elsif (FUNC = "010000") then --MFHI
                        Mult_reg_sel <= '1'; --select upper multiplier out bits
                        next_state <= mult_comp;
                    elsif (FUNC = "010010") then
                        Mult_reg_sel <= '0'; --select lower multiplier out bits
                        next_state <= mult_comp;
                    end if;
                    
                --I-type
                elsif (OP = "001000") then --add immediate
                    sign_sel <= '1';
                    RegDst <= '0'; --select 20 downto 16 for destination register
                    ALUA <= '1'; --latch ALU inputs
                    ALUB <= '1';
                    ALUOp <= "0100"; --add signed
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "10"; --select 32 bit extended immediate
                    next_state <= exec;
                elsif (OP = "001101") then --or immediate
                    RegDst <= '0'; --select 20 downto 16 for destination register
                    ALUA <= '1'; --latch ALU inputs
                    ALUB <= '1';
                    ALUOp <= "0001"; --or
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "10"; --select 32 bit extended immediate
                    sign_sel <= '0';
                    next_state <= exec;
                elsif (OP = "001010") then --SLTI immediate
                    RegDst <= '0'; --select 20 downto 16 for destination register
                    ALUA <= '1'; --latch ALU inputs
                    ALUB <= '1';
                    ALUOp <= "1010"; --shift left signed
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "10"; --select 32 bit extended immediate
                    next_state <= exec;
                elsif (OP = "001111") then --LUI
                    RegDst <= '0'; --select 20 downto 16 for destination register
                    RegWrite <= '1'; --enable writing to register
                    MemtoReg <= "10"; --write sign extended immediate to register
                    
                    next_state <= LUI_comp;
                    
                --J-type
                elsif (OP = "000101") then --BNE
                    ALUA <= '1'; --latch ALU inputs
                    ALUB <= '1';
                    ALUOp <= "0110"; --sub
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "00"; --set SrcB to regB
                    next_state <= branch_comp;
                elsif (OP = "000010") then --J
                    PCSource <= "10"; --set next PC to result shifted jump immediate 
                    PCWrite <= '1'; --update pc reg with immediate jump addr
                    next_state <= ins_fetch;
                elsif (OP = "000001") then --BLTZAL, TODO
                    next_state <= branch_comp;
                elsif (OP = "101011" or OP = "100011" or OP = "100000" or OP = "100001") then --SW, LW, LB, LW
                    ALUA <= '1'; --latch ALU A inputs for base addr
                    ALUB <= '1'; --latch ALU B reg for SW val
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "10"; --set SrcB to immediate offset
                    ALUOp <= "0101"; --add unsigned
                    next_state <= mem_comp;
                elsif (OP = "011100") then --CLO
                    ALUA <= '1'; --latch ALU A inputs for rs
                    next_state <= clo_comp;
                end if;
            when exec =>
                ALUA <= '0'; --close ALU regs
                ALUB <= '0';
                ALUOut <= '1'; --latch ALU result next pulse
                next_state <= r_comp;
            when r_comp =>
                if (OP = "000000") then
                    RegDst <= '1'; --select rd for reg addr
                else
                    RegDst <= '0'; --select rt for reg addr for immediate ins
                end if;
                MemToReg <= "00"; --write back ALU result to dst reg
                RegWrite <= '1'; --enable writing to registers
                
                ALUOut <= '0'; --close ALUOut reg
                ALUSrcA <= '0'; --set SrcA to PC out
                ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                ALUOp <= "0101"; --set ALU to unsigned addition
                PCSource <= "00"; --set next PC to result of ALU: current PC +4
                PCWrite <= '1'; --update pc reg with +4 pc
                next_state <= ins_fetch;
            when branch_comp => --how to advance pc if not branch?
                PCWriteCond <= '1'; --enable branch cond for ANDing with zero flag
                
                ALUA <= '0'; --close ALU regs
                ALUB <= '0';
                
                ALUSrcA <= '0'; --set SrcA to PC out
                ALUSrcB <= "10"; --set ALU B to extended immediate (PC offset)
                ALUOp <= "0101"; --set ALU to unsigned addition
                
                PCSource <= "00"; --set next PC to ALU result
                PCWrite <= '1'; --update pc reg with immediate jump addr
                
                next_state <= ins_fetch;
            when jump_comp =>
                PCSource <= "11"; --set next PC to result shifted jump immediate 
                PCWrite <= '1'; --update pc reg with immediate jump addr
                next_state <= ins_fetch;
            when mem_comp =>
                ALUA <= '0'; --close ALU A reg
                ALUB <= '0'; --close ALU B reg
                ALUOut <= '1'; --latch ALU result from computing new address
                next_state <= mem_access;
            when mem_access =>
                ALUOut <= '0'; --close ALU out reg
                IorD <= '1'; --select ALU out as input to memory address
                
                if (OP = "101011") then --SW
                    MemWrite <= '1'; --enable memory write
                    ALUB <= '0'; --close ALU B reg
                    
                    ALUSrcA <= '0'; --set SrcA to PC out
                    ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                    ALUOp <= "0101"; --set ALU to unsigned addition
                    PCSource <= "00"; --set next PC to result of ALU: current PC +4
                    PCWrite <= '1'; --update pc reg with +4 pc
                    next_state <= ins_fetch;
                elsif (OP = "100011" or OP = "100000" or OP = "100001") then
                    MemRegEn <= '1'; --store data from memory into memory reg
                    next_state <= mem_read_comp;
                end if;
            when mem_read_comp =>
                MemRegEn <= '0';
                RegDst <= '0'; --select 20 downto 16 from isntruction
                MemtoReg <= "01"; --select mem reg to write to reg file
                RegWrite <= '1'; --write to reg
                
                ALUSrcA <= '0'; --set SrcA to PC out
                ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                ALUOp <= "0101"; --set ALU to unsigned addition
                PCSource <= "00"; --set next PC to result of ALU: current PC +4
                PCWrite <= '1'; --update pc reg with +4 pc
                next_state <= ins_fetch;
            when LUI_comp =>
                ALUSrcA <= '0'; --set SrcA to PC out
                ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                ALUOp <= "0101"; --set ALU to unsigned addition
                PCSource <= "00"; --set next PC to result of ALU: current PC +4
                PCWrite <= '1'; --update pc reg with +4 pc
                next_state <= ins_fetch;
            when mult_exec =>
                Mult_rst <= '0'; 
                ALUA <= '0'; --close ALU regs
                ALUB <= '0';
                if (Done = '1') then
                    HI_en <= '1';
                    LO_en <= '1';
                    
                    ALUSrcA <= '0'; --set SrcA to PC out
                    ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                    ALUOp <= "0101"; --set ALU to unsigned addition
                    PCSource <= "00"; --set next PC to result of ALU: current PC +4
                    PCWrite <= '1'; --update pc reg with +4 pc
                    
                    next_state <= ins_fetch;
                end if;
            when mult_comp =>
                MemtoReg <= "11"; --select muxed multiplier output
                RegDst <= '1'; --select 15 downto 11 for reg destination
                RegWrite <= '1'; --enable writing to registers
                
                ALUOut <= '0'; --close ALUOut reg
                ALUSrcA <= '0'; --set SrcA to PC out
                ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                ALUOp <= "0101"; --set ALU to unsigned addition
                PCSource <= "00"; --set next PC to result of ALU: current PC +4
                PCWrite <= '1'; --update pc reg with +4 pc
                next_state <= ins_fetch;
            when clo_comp =>
                RegWrite <= '1'; --enable writing to registers
                RegDst <= '1';
                leading_sel <= '1';
                
                ALUOut <= '0'; --close ALUOut reg
                ALUSrcA <= '0'; --set SrcA to PC out
                ALUSrcB <= "01"; --set ALU B to +4 for advancing PC
                ALUOp <= "0101"; --set ALU to unsigned addition
                PCSource <= "00"; --set next PC to result of ALU: current PC +4
                PCWrite <= '1'; --update pc reg with +4 pc
                next_state <= ins_fetch;
            when others =>
                next_state <= ins_fetch;
        end case;
    end process;

end Behavioral;
