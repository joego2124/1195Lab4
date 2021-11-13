----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2021 02:16:20 PM
-- Design Name: 
-- Module Name: Shift - Behavioral
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

entity Shift is
  Port (
    A       : in  std_logic_vector(31 downto 0);
    SHAMT   : in  std_logic_vector(4 downto 0);
    ALUop   : in  std_logic_vector(1 downto 0);
    ShiftR  : out std_logic_Vector(31 downto 0)
  );
end Shift;

architecture Behavioral of Shift is

    signal L0: std_logic_vector(31 downto 0);
    signal L1: std_logic_vector(31 downto 0);
    signal L2: std_logic_vector(31 downto 0);
    signal L3: std_logic_vector(31 downto 0);
    signal L4: std_logic_vector(31 downto 0);
    
    signal R0: std_logic_vector(31 downto 0);
    signal R1: std_logic_vector(31 downto 0);
    signal R2: std_logic_vector(31 downto 0);
    signal R3: std_logic_vector(31 downto 0);
    signal R4: std_logic_vector(31 downto 0);
    
    signal Fill : std_logic_vector(31 downto 0);
begin

    Fill <= (others => ALUop(0) and A(31));
    
    L0 <= A(30 downto 0) & '0' when SHAMT(0) = '1' else A;
    L1 <= L0(29 downto 0) & "00" when SHAMT(1) = '1' else L0;
    L2 <= L1(27 downto 0) & "0000" when SHAMT(2) = '1' else L1;
    L3 <= L2(23 downto 0) & "00000000" when SHAMT(3) = '1' else L2;
    L4 <= L3(15 downto 0) & "0000000000000000" when SHAMT(4) = '1' else L3;
    
    R0 <= Fill(0) & A(31 downto 1) when SHAMT(0) = '1' else A;
    R1 <= Fill(1 downto 0) & R0(31 downto 2) when SHAMT(1) = '1' else R0;
    R2 <= Fill(3 downto 0) & R1(31 downto 4) when SHAMT(2) = '1' else R1;
    R3 <= Fill(7 downto 0) & R2(31 downto 8) when SHAMT(3) = '1' else R2;
    R4 <= Fill(15 downto 0) & R3(31 downto 16) when SHAMT(4) = '1' else R3;
    
    ShiftR <= R4 when ALUop(1) = '1' else L4;

end Behavioral;
