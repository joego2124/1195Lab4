----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2021 05:04:08 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
    Port (
        A, B     : in std_logic_vector(31 downto 0);
        CLK, RST : in std_logic;
        R        : out std_logic_vector(63 downto 0);
        DONE     : out std_logic := '0'
    );
end Control;

architecture Behavioral of Control is

    component ShiftReg is
        Generic (N : positive := 32);
        Port (
            DIR, CLK, SET, D, SHIFT : in std_logic;
            INPUT                   : in std_logic_vector(N - 1 downto 0);
            Q                       : out std_logic_vector(N - 1 downto 0)
        );
    end component;
    
    component flipflop is
        generic (N : positive := 64);
        Port (
            CLK : in std_logic;
            D   : in std_logic_vector(N - 1 downto 0);
            EN  : in std_logic;
            RST : in std_logic;
            Q   : out std_logic_vector(N - 1 downto 0)
        );
    end component;
    
    component addsub is
        generic( n : positive := 32 );
        Port (
            A, B : in  std_logic_vector(n-1 downto 0);
            K    : in  std_logic;
            S    : out std_logic_vector(n-1 downto 0)
        );
    end component;
    
    signal temp_A, product_out, multiplicand_out, alu_out : std_logic_vector(63 downto 0);
    signal multiplier_out : std_logic_vector(31 downto 0);
    signal product_en, product_rst : std_logic := '0';
    signal multiplicand_set, multiplier_set : std_logic := '0'; 
    signal multiplier_shift, multiplicand_shift : std_logic := '0';
    signal count : integer := 0;
    
    type state_type is (
        start, test, shift, check, finish
    );
    
    signal state : state_type;
begin

    Prod_Reg : flipflop 
        generic map (N => 64)
        port map (
            CLK => CLK,
            D => alu_out,
            EN => product_en,
            RST => product_rst,
            Q => product_out
        );

    ALU : addsub
        generic map (n => 64)
        port map (
            A => product_out,
            B => multiplicand_out,
            K => '0',
            S => alu_out
        );

    Multiplicand_reg : ShiftReg
        generic map (N => 64)
        port map (
            DIR => '0',
            CLK => CLK,
            SET => multiplicand_set,
            D => '0',
            SHIFT => multiplicand_shift,
            INPUT => temp_A,
            Q => multiplicand_out
        );
        
    Multiplier_reg : ShiftReg
        generic map (N => 32)
        port map (
            DIR => '1',
            CLK => CLK,
            SET => multiplier_set,
            D => '0',
            SHIFT => multiplier_shift,
            INPUT => B,
            Q => multiplier_out
        );
        
    process (A)
    begin
        temp_A(63 downto 32) <= (others => '0');
        temp_A(31 downto 0) <= A;
    end process;

    process (CLK, RST)
    begin
        
        --reset to original state
        if (RST = '1') then
            state <= start;
        end if;
        
        if (CLK'event and CLK = '1') then
            case state is
                when start =>
                    --not done
                    DONE <= '0';
                    
                    --reset counter
                    count <= 0;
                     
                    --reset product reg
                    product_rst <= '1'; 
                    
                    --load A and B into shift registers without shifting
                    multiplier_set <= '1';
                    multiplicand_set <= '1';
                    multiplicand_shift <= '0';
                    multiplier_shift <= '0';
                    
                    state <= test; --advance state
                    
                when test =>
                    --prevent shift reg being overwritten by control inputs
                    multiplier_set <= '0';
                    multiplicand_set <= '0';
                    product_rst <= '0'; 
                
                    if (multiplier_out(0) = '1') then
                        product_en <= '1'; --put result of alu into prod reg
                    end if;
                    state <= shift; --advance state
                
                when shift =>
                   product_en <= '0'; --keep prod reg
                   multiplicand_shift <= '1'; --shift multiplicand left
                   multiplier_shift <= '1'; --shift multiplier left
                   state <= finish; --advance state
                   
                when finish =>
                    --turn off shifts
                    multiplicand_shift <= '0'; 
                    multiplier_shift <= '0'; 
                   
                    if (count = 31) then --finished
                        R <= product_out;
                        DONE <= '1';
                    else --go back to test state and increase rep
                        count <= count + 1;
                        state <= test;
                    end if;
                    
                when others =>
                    state <= start;
            end case;
        end if;
    
    end process;

end Behavioral;
