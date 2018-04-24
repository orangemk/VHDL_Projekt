library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Zeile wird als fehlerhaft markiert, Simulation und Synthese geht aber.
use ieee.math_real.all;

-- Tatsaechlicher Faktor fuer die Frequenzteilung ist
-- der doppelte Wert von DIV, z.B. CLK = 100 MHz, DIV = 2,
-- die Ausgangsfrequenz ist 25 MHz.
--
-- DIV muss groesser/gleich 2 sein.

entity clk_div is
    generic (DIV: integer := 4);
    port (clk_in: in std_logic;
          clk_out: out std_logic);

    -- Zeile wird als fehlerhaft markiert, Simulation und Synthese geht aber.
    constant N: integer := integer(ceil(log2(real(DIV))));
    constant RELOAD: std_logic_vector := std_logic_vector(to_signed(-DIV+1, N));
end clk_div;

architecture impl of clk_div is
    component timer is
        generic (N: integer := 32);
        port (clk, enable: in std_logic;
              reload: in std_logic_vector(N-1 downto 0);
              count: out std_logic_vector(N-1 downto 0);
              overflow: out std_logic);
    end component;

    signal overflow_int, clk_out_int: std_logic := '0';
begin
    assert (DIV >= 2) report "DIV muss groesser/gleich 2 sein." severity failure;

    t: timer
        generic map (N => N)
        port map (clk => clk_in, enable => '1', reload => RELOAD,
                 overflow => overflow_int);

    process (overflow_int)
    begin
        if rising_edge(overflow_int) then
            clk_out_int <= not clk_out_int;
        end if;
    end process;

    clk_out <= clk_out_int;
end impl;

