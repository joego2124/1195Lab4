----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2021 02:40:53 PM
-- Design Name: 
-- Module Name: ShiftReg - Behavioral
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
use IEEE.numeric_std;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftReg is
    Generic (N : positive := 32);
    Port (
        DIR, CLK, SET, D, SHIFT : in std_logic;
        INPUT                   : in std_logic_vector(N - 1 downto 0);
        Q                       : out std_logic_vector(N - 1 downto 0)
    );
end ShiftReg;

architecture Behavioral of ShiftReg is
    signal Q_temp : std_logic_vector(N - 1 downto 0);
begin

    Q <= Q_temp;

    process(CLK, SET)
    begin
    
        if (SET = '1') then
            Q_temp <= INPUT;
        elsif (CLK'event and CLK='1' and SHIFT = '1') then
            if (DIR = '0') then --shift left
                Q_temp(N - 1 downto 1) <= Q_temp(N - 2 downto 0);
                Q_temp(0) <= D;
            else
                Q_temp(N - 2 downto 0) <= Q_temp(N - 1 downto 1);
                Q_temp(N - 1) <= D;
            end if;   
        end if;
    
    end process;

end Behavioral;
