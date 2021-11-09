----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2021 02:23:54 PM
-- Design Name: 
-- Module Name: Register - Behavioral
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

entity flipflop is
    generic (N : positive := 64);
    Port (
        CLK : in std_logic;
        D   : in std_logic_vector(N - 1 downto 0);
        EN  : in std_logic;
        RST : in std_logic;
        Q   : out std_logic_vector(N - 1 downto 0)
    );
end flipflop;

architecture flipflop of flipflop is
begin
    CLKD : process(CLK, RST)
    begin
        if (RST = '1') then
            Q <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (EN = '1') then
                Q <= D;
            end if;
        end if;
    end process CLKD;
end flipflop;
