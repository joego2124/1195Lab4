----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2021 12:03:36 PM
-- Design Name: 
-- Module Name: Registers - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers is
  Port (
    CLK, RST, EN : in std_logic;
    IN1, IN2, W : in std_logic_vector(4 downto 0);
    D : in std_logic_vector(31 downto 0);
    OUT1, OUT2 : out std_logic_vector(31 downto 0)
  );
end Registers;

architecture Behavioral of Registers is

--    component flipflop is
--        generic (N : positive := 32);
--        Port (
--            CLK : in std_logic;
--            D   : in std_logic_vector(N - 1 downto 0);
--            EN  : in std_logic;
--            RST : in std_logic;
--            Q   : out std_logic_vector(N - 1 downto 0)
--        );
--    end component;

    type arr is array(31 downto 0) of std_logic_vector(31 downto 0);
    type arr2 is array(31 downto 0) of std_logic;
    signal SEL : arr2;
    signal Q_temp : arr;
begin

--    GEN: for i in 0 to 31 generate
--        REG : flipflop
--            generic map(N => 32) 
--            port map (
--                CLK => CLK,
--                D => D,
--                EN => SEL(i),
--                RST => RST,
--                Q => Q_temp(i)
--            );
--    end generate GEN;
    
    OUT1 <= Q_temp(to_integer(unsigned(IN1)));
    OUT2 <= Q_temp(to_integer(unsigned(IN2)));
    
--    process(W)
--    begin
--        if (EN = '1') then
--            SEL(31 downto 0) <= (others => '0');
--            SEL(to_integer(unsigned(W))) <= '1';
--        end if;
--    end process;
    
    process(CLK, EN, RST)
    begin
        if (RST = '1') then
            Q_temp <= (others => x"00000000");
        elsif ((CLK'event and CLK='1') and (EN = '1')) then
            Q_temp(to_integer(unsigned(W))) <= D;
        end if;
    end process;
    
end Behavioral;
