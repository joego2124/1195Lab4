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
end CPUControl;

architecture Behavioral of CPUControl is
    
    type state_type is (
        ins_fetch, ins_decode, exec, r_comp, write_back
    );
    
    signal pr_state, next_state : state_type;
    
    signal OP, FUNC : std_logic_vector(5 downto 0);
begin

    OP <= INS(31 downto 26);
    FUNC <= INS(5 downto 0);

    process (CLK, RST)
    begin
        if (RST = '1') then
            pr_state <= ins_fetch;
        elsif (CLK'event and CLK = '1') then
            pr_state <= next_state;
        end if;
    end process;
    
    process (OP, FUNC, pr_state)
    begin
        case pr_state is
            when ins_fetch =>
                IorD <= '0'; --default to PC reg
                IRWrite <= '1'; --write instruction to instruction reg
                next_state <= ins_decode;
            when ins_decode =>
                IRWrite <= '0';
                if (OP = "000000") then
                    ALUA <= '1'; --latch ALU inputs
                    ALUB <= '1';
                    ALUSrcA <= '1'; --set SrcA to regA
                    ALUSrcB <= "00"; --set SrcB to regB
                    
                    if (FUNC = "100001") then --ADDU
                        ALUOp <= "0101"; 
                    elsif (FUNC = "100100") then --AND
                        ALUOp <= "0000";
                    elsif (FUNC = "100010") then --SUB
                        ALUOp <= "0110";
                    elsif (FUNC = "000011") then --SRA
                        ALUOp <= "1111";
                    elsif (FUNC = "000100") then --SLLV
                        ALUOp <= "1100";
                    elsif (FUNC = "000000") then --SLL
                        ALUOp <= "1100";
                    end if;
                    
                    next_state <= exec;
                end if;
            when exec =>
                ALUA <= '0'; --close ALU regs
                ALUB <= '0';
                ALUOut <= '1'; --latch ALU result next pulse
            when r_comp =>
                ALUOut <= '0'; --close ALUOut reg
                MemToReg <= '0'; --write back ALU result to dst reg
                ALUSrcA <= '0'; --set SrcA to regA
                ALUSrcB <= "01";
                PCSource <= "00"; --set next PC to result of ALU: current PC +4
                PCWrite <= '1'; --update pc reg with +4 pc
                next_state <= ins_fetch;
            when others =>
                next_state <= ins_fetch;
        end case;
    end process;

end Behavioral;
