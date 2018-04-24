----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2018 17:36:11
-- Design Name: 
-- Module Name: tb_PWM - Behavioral
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

entity tb_PWM is
--  Port ( );
end tb_PWM;

architecture Behavioral of tb_PWM is

component PWM is port(
    CLK100MHZ : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR (8 downto 0);
    PWM_out : out STD_LOGIC;
    counter_out : out STD_LOGIC_VECTOR (8 downto 0)
    );
end component;

signal CLK100MHZ_sig : std_logic := '0';
signal PWM_out_sig : std_logic := '0';
signal counter_out_sig : std_logic_vector(8 downto 0) := "000000000";

begin

x1: PWM port map(
CLK100MHZ   => CLK100MHZ_sig,
di_in       => "101101010",
PWM_out     => PWM_out_sig,
counter_out => counter_out_sig
);

CLK100MHZ_sig <=    not CLK100MHZ_sig after 5ns;

end Behavioral;