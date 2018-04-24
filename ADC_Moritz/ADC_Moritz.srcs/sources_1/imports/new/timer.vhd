library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
    generic (N: integer := 32);
    port (clk, enable: in std_logic;
          reload: in std_logic_vector(N-1 downto 0);
          count: out std_logic_vector(N-1 downto 0);
          overflow: out std_logic);
end timer;

architecture impl of timer is
    signal count_int: std_logic_vector(N downto 0) := (others=>'0');
    signal overflow_int: std_logic := '0';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if (overflow_int = '1') then
                count_int <= '0' & reload;
            elsif (enable = '1') then
                count_int <= std_logic_vector(unsigned(count_int) + 1);
            else
                count_int <= (others => '0');
            end if;
        end if;
    end process;

    overflow_int <= count_int(N);
    overflow <= overflow_int;
    count <= count_int(N-1 downto 0);
end impl;

