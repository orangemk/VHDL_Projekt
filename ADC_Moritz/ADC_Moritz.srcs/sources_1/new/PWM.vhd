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
--library UNISIM;
--use UNISIM.VComponents.all;

--use IEEE.STD_Logic_arith.all;
use IEEE.Std_logic_unsigned.all;

entity PWM is
Port ( 
  CLK100MHZ : in STD_LOGIC;
  PWM_in : in STD_LOGIC_VECTOR (8 downto 0);
  PWM_out : out STD_LOGIC
);
end PWM;

architecture Behavioral of PWM is

signal counter : STD_LOGIC_VECTOR (8 downto 0) := (others=>'0');
signal buffer_pwm : STD_LOGIC_VECTOR (8 downto 0) := (others=>'0');

begin

p1: process (CLK100MHZ, counter, PWM_in)
begin
    if falling_edge (CLK100MHZ) then
        counter <= counter + 1;
        if counter = 0 then
             PWM_out <= '1';
             buffer_pwm <= PWM_in;
        elsif unsigned(counter) = unsigned(buffer_pwm) then
             PWM_out <= '0';
        end if;
     end if;
end process;

end Behavioral;
