----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2018 18:43:19
-- Design Name: 
-- Module Name: Sieben_Seg - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Sieben_Seg_Taster is
    Port ( 
        CLK100MHZ : in STD_LOGIC;
        BTNU : in STD_LOGIC;
        BTND : in STD_LOGIC;
        AN : out STD_LOGIC_VECTOR (7 downto 0);
        SEG : out STD_LOGIC_VECTOR (7 downto 0));
end Sieben_Seg_Taster;

architecture Behavioral of Sieben_Seg_Taster is

component debounce is port(
  CLK100MHz: in std_logic; 
  switch_input : in std_logic; 
  debounced_output : out std_logic);
end component;

signal BTNU_sig : std_logic := '0';
signal BTND_sig : std_logic := '0';
signal debounced_BTNU : std_logic := '0';
signal debounced_BTND : std_logic := '0';
signal count : STD_LOGIC_VECTOR (2 downto 0) := "000";
signal edge_taster1 : std_logic_vector(1 downto 0):="00";
signal edge_taster2 : std_logic_vector(1 downto 0):="00";

begin

d1: debounce port map (CLK100MHz => CLK100MHz, switch_input => BTNU, debounced_output => debounced_BTNU);
d2: debounce port map (CLK100MHz => CLK100MHz, switch_input => BTND, debounced_output => debounced_BTND);

AN <= "11111110";   -- nur rechteste 7-Seg einschalten

x1: process (CLK100MHZ, count)
begin
if rising_edge (CLK100MHZ) then
   edge_taster1 <= edge_taster1(0) & debounced_BTNU;
   edge_taster2 <= edge_taster2(0) & debounc
   ed_BTND;

   if (edge_taster1 = "01") and count /= "111" then
      count <= count + 1;
   elsif (edge_taster2 = "01") and count /= "000" then
      count <= count - 1;
   end if;
end if;

case count is
    when "000" =>   SEG <= "11000000";   -- 0
    when "001" =>   SEG <= "11111001";   -- 1
    when "010" =>   SEG <= "10100100";   -- 2
    when "011" =>   SEG <= "10110000";   -- 3
    when "100" =>   SEG <= "10011001";   -- 4
    when "101" =>   SEG <= "10010010";   -- 5
    when "110" =>   SEG <= "10000010";   -- 6
    when "111" =>   SEG <= "11111000";   -- 7
    when others =>  SEG <= "11111111";   -- aus
end case;
end process;

end Behavioral;
