----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2021 06:23:24 PM
-- Design Name: 
-- Module Name: CPU_tb - Behavioral
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

entity CPU_tb is
--  Port ( );
end CPU_tb;

architecture Behavioral of CPU_tb is

    component CPU is
        Port (
            Reset, Clock : in std_logic;
            MemoryWrite  : out std_logic;
            MemoryDataIn : in std_logic_vector(31 downto 0);
            MemoryDataOut, MemoryAdress: out std_logic_vector(31 downto 0)
        );
    end component CPU;
    
    component CPU_memory IS
        PORT( 
          Clk      : IN     std_logic;
          MemWrite : IN     std_logic;
          addr     : IN     std_logic_vector (31 DOWNTO 0);
          dataIn   : IN     std_logic_vector (31 DOWNTO 0);
          dataOut  : OUT    std_logic_vector (31 DOWNTO 0)
        );
    END component CPU_memory;

    signal RST, MemWrite, CLK : std_logic;
    signal Data_in, Data_out, addr : std_logic_vector (31 DOWNTO 0);

begin

    CPU_Unit : CPU
        port map (
            Reset => RST, Clock => CLK,
            MemoryWrite => MemWrite,
            MemoryDataIn => Data_out,
            MemoryDataOut => Data_in,
            MemoryAdress => addr
        );
    
    CPU_Mem : CPU_memory
        port map (
            Clk => CLK, MemWrite => MemWrite,
            addr => addr,
            dataIn => Data_in,
            dataOut => Data_out
        );
    
end Behavioral;
