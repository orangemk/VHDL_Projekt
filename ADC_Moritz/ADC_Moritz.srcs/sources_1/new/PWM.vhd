----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2018 12:02:14
-- Design Name: 
-- Module Name: PWM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity PWM is
    Port ( 
    CLK100MHZ : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR (8 downto 0);
    PWM_out : out STD_LOGIC;
    counter_out : out STD_LOGIC_VECTOR (8 downto 0)
    );
end PWM;

architecture Behavioral of PWM is

signal counter : STD_LOGIC_VECTOR (8 downto 0) := "000000000";

begin

process (CLK100MHZ)
begin
    if rising_edge(CLK100MHZ) then
        counter <= std_logic_vector( unsigned(counter) + 1 );
        
        if counter = "000000000" then
            PWM_out <= '1';
        elsif counter = di_in then
            PWM_out <= '0';
        end if;
        
    end if;
end process;

counter_out <= counter;

end Behavioral;
