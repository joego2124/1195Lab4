----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2021 11:24:42 AM
-- Design Name: 
-- Module Name: Comp - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comp is
  Port (
    A_31  : in std_logic;
    B_31  : in std_logic;
    S_31  : in std_logic;
    CO    : in std_logic;
    ALUop : in std_logic_vector(1 downto 0);
    R     : out std_logic_vector(31 downto 0)
  );
end Comp;

architecture Behavioral of Comp is

    signal temp : std_logic_vector(5 downto 0);

begin

    temp(5 downto 4) <= ALUop;
    temp(3) <= A_31;
    temp(2) <= B_31;
    temp(1) <= S_31;
    temp(0) <= CO;

    R <= x"00000000" when temp(5) = '0' else
         x"00000000" when temp(5 downto 1) = "10000" else
         x"00000001" when temp(5 downto 1) = "10001" else
         x"00000000" when temp(5 downto 1) = "10110" else
         x"00000001" when temp(5 downto 1) = "10111" else
         x"00000001" when temp(5 downto 2) = "1010" else
         x"00000000" when temp(5 downto 2) = "1001" else
         x"00000000" when STD_MATCH(temp, "11---1") else
         x"00000001" when STD_MATCH(temp, "11---0") else
         x"00000000";

end Behavioral;
