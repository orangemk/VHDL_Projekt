library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Frequenzteilung mit 2^n. LSB von Ausgang count ist unveraenderte
-- Eingangsfrequenz CLK, naechtes Bit hat CLK/2 usw. MSB hat Frequenz
-- CLK/2^(N-1).

entity clk_div_pow2 is
    generic(N: integer := 4); -- N bits
    port (clk_in: in std_logic;
          count: out std_logic_vector(N-1 downto 0));
end clk_div_pow2;

architecture impl of clk_div_pow2 is
    signal count_int: std_logic_vector (N-2 downto 0) := (others => '1');
    signal clk_int: std_logic;
begin
    count <= count_int & clk_int;
    clk_int <= clk_in;
    
    process (clk_int)
    begin
         if rising_edge(clk_int) then
            count_int <= std_logic_vector(unsigned(count_int) - 1); -- count
         end if;
    end process;
end impl;
