----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2021 10:48:09 AM
-- Design Name: 
-- Module Name: SignExtend - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignExtend is
  generic (
    INL   : positive := 16;
    OUTL  : positive := 32;
    SHIFT : integer := 0
  );
  Port (
    INPUT  : in std_logic_vector(INL - 1 downto 0);
    OUTPUT : out std_logic_vector(OUTL - 1 downto 0) := (others => '0');
    sign_sel : in std_logic
  );
end SignExtend;

architecture Behavioral of SignExtend is
    signal extended : std_logic_vector(OUTL - 1 downto 0);
begin

--    OUTPUT((INL - 1 + SHIFT) downto SHIFT) <= INPUT; 

    process(INPUT, extended, sign_sel)
    begin
        if (sign_sel = '0') then
            extended <= (others => '0');
        else
            if (INPUT(INL - 1) = '1') then
                extended <= (others => '1');
            else
                extended <= (others => '0');            
            end if;
        end if;
        extended(INL - 1 downto 0) <= INPUT;
        OUTPUT <= std_logic_vector(shift_left(unsigned(extended), SHIFT));
--        OUTPUT <= extended;
    end process;

end Behavioral;
