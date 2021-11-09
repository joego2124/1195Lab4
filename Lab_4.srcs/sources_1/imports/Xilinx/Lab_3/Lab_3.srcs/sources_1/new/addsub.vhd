----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2021 12:12:42 PM
-- Design Name: 
-- Module Name: addsub - Behavioral
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

entity addsub is
    generic( n : positive := 32 );
    Port (
        A, B : in  std_logic_vector(n-1 downto 0);
        K    : in  std_logic;
        S    : out std_logic_vector(n-1 downto 0)
    );
end addsub;

architecture Behavioral of addsub is

component full_adder
	Port (
        A, B, C_in : in std_logic;
        S, C_out: out std_logic
    );
end component;

signal B_xor_K  : std_logic_vector(n-1 downto 0);
signal K_vec    : std_logic_vector(n-1 downto 0);
signal C_out    : std_logic_vector(n-1 downto 0);

begin

    K_vec <= (others => k);
    B_xor_K <= B xor K_vec;

    first_full_adder: full_adder 
        port map(
            A => a(0), 
            B => B_xor_K(0),
            C_in => K,
            S => s(0),
            C_out => C_out(0)
        );
    g1: for i in 1 to n-1 generate
        full_adders: full_adder 
            port map(
                A => a(i), 
                B => B_xor_K(i),
                C_in => C_out(i - 1),
                S => s(i),
                C_out => C_out(i)
            );
    end generate;
    
end Behavioral;
