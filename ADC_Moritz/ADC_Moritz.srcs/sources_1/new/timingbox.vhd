----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2018 14:19:25
-- Design Name: 
-- Module Name: timingbox - Behavioral
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

use IEEE.Std_logic_unsigned.all;

entity timingbox is Port (
  CLK100MHZ : in STD_LOGIC;
  CLK25kHZ : out STD_LOGIC;
  PWM_7Seg : out STD_LOGIC
);
end timingbox;

architecture Behavioral of timingbox is

component clk_div is
        generic (DIV: integer := 4);
        port (clk_in: in std_logic;
              clk_out: out std_logic);
end component;

component clk_div_pow2 is
        generic (N: integer := 4); -- N bits
        port (clk_in: in std_logic;
              count: out std_logic_vector(N-1 downto 0));
end component;

signal clk_100MHz, clk_2MHz, clk_1MHz, clk_500kHz, clk_250kHz, clk_25kHz: std_logic := '1';
signal mod_signal, data, demod_sync_pulse, bit_int: std_logic := '0';
signal clk_pow2: std_logic_vector(3 downto 0) := (others => '0');
signal count : std_logic_vector(3 downto 0) := (others=>'0');
signal count_pwm : std_logic_vector(7 downto 0) := (others=>'0');

begin

clk_1MHz <= clk_pow2(1);
clk_500kHz <= clk_pow2(2);
clk_250kHz <= clk_pow2(3);
CLK25kHZ <= clk_25kHz;

clk_div_2MHz: clk_div
generic map (DIV => 25)
port map (clk_in => CLK100MHZ, clk_out => clk_2MHz);

clk_div_pow2_N4: clk_div_pow2
generic map (N => 4)
port map (clk_in => clk_2MHz, count => clk_pow2);

p1: process (clk_250kHz, count)
begin
    if rising_edge(clk_250kHz) then
        count <= count + 1;
    end if;
    
    if count = 5 then
        count <= "0000";
        clk_25kHz <= not clk_25kHz;
    end if;
end process;

p2: process (CLK100MHz, count_pwm)
begin
    if rising_edge (CLK100MHz) then
        count_pwm <= count_pwm + 1;
        if count_pwm = 0 then
             PWM_7Seg <= '1';
        elsif count_pwm = "00100000" then
             PWM_7Seg <= '0';
        end if;
    end if;
end process;
    

end Behavioral;
