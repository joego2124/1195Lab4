----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2021 06:57:52 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
  Port (
    A, B            : in std_logic_vector(31 downto 0);
    SHAMT           : in std_logic_vector(4 downto 0);
    ALUop           : in std_logic_vector(3 downto 0);
    R               : out std_logic_vector(31 downto 0);
    Overflow, Zero  : out std_logic
  );
end ALU;

architecture Behavioral of ALU is

    component Logical is
      Port (
        A       : in  std_logic_vector(31 downto 0);
        B       : in  std_logic_vector(31 downto 0);
        ALUop   : in  std_logic_vector(1 downto 0);
        LogicalR: out std_logic_Vector(31 downto 0)
      );
    end component;

    component Shift is
      Port (
        A       : in  std_logic_vector(31 downto 0);
        SHAMT   : in  std_logic_vector(4 downto 0);
        ALUop   : in  std_logic_vector(1 downto 0);
        ShiftR  : out std_logic_Vector(31 downto 0)
      );
    end component;

    component Comp is
      Port (
        A_31  : in std_logic;
        B_31  : in std_logic;
        S_31  : in std_logic;
        CO    : in std_logic;
        ALUop : in std_logic_vector(1 downto 0);
        R     : out std_logic_vector(31 downto 0)
      );
    end component;

    component Arith_Unit IS
       GENERIC (
          n       : positive := 32);
       PORT( 
          A       : IN     std_logic_vector (n-1 DOWNTO 0);
          B       : IN     std_logic_vector (n-1 DOWNTO 0);
          C_op    : IN     std_logic_vector (1 DOWNTO 0);
          CO      : OUT    std_logic;
          OFL     : OUT    std_logic;
          S       : OUT    std_logic_vector (n-1 DOWNTO 0);
          Z       : OUT    std_logic
       );
    END component;

    signal LogicalR, ArithR, CompR, ShiftR : std_logic_vector(31 downto 0);
    signal CO : std_logic;
    
begin

    U1 : Logical port map(
        A        => A,
        B        => B,
        ALUop    => ALUop(1 downto 0),
        LogicalR => LogicalR
    );
    
    U2 : Shift port map(
        A        => B,
        SHAMT    => SHAMT,
        ALUop    => ALUop(1 downto 0),
        ShiftR => ShiftR
    );
    
    U3 : Comp port map(
        A_31  => A(31),
        B_31  => B(31),
        S_31  => ArithR(31),
        CO    => CO,
        ALUop => ALUop(1 downto 0),
        R     => CompR
    );
    
    U4 : Arith_Unit port map(
        A => A,
        B => B,
        C_op => ALUop(1 downto 0),
        CO => CO,
        OFL => Overflow,
        S => ArithR,
        Z => Zero
    );
    
    R <= LogicalR when (ALUop(3 downto 2) = "00") else
         ArithR   when (ALUop(3 downto 2) = "01") else
         CompR    when (ALUop(3 downto 2) = "10") else
         ShiftR;

end Behavioral;
