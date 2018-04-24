library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;

entity transmitter_test is
end transmitter_test;

architecture impl of transmitter_test is

    component window_sync
        Port ( clk_100M : in STD_LOGIC;
               clk_500k : in STD_LOGIC;
               window_state : in freq_state;
               sync_2M : in STD_LOGIC;
               demod_state : out freq_state);
    end component;

    component window_det
    Port ( clk : in STD_LOGIC;
           rec : in STD_LOGIC;
           freq_out : out freq_state;
           sync_pulse : out STD_LOGIC);
    end component;

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

    component mod_mux is
        port (clk_in: in std_logic;
              freq_sel: in freq_state;
              freq_1, freq_2: in std_logic;
              freq_out : out std_logic);
    end component;

    component frame_builder is
        port (clk_500khz: in std_logic;
              data: in std_logic; -- Datenrate 250kHz
              freq_sel: out freq_state);
    end component;

    signal clk_100MHz, clk_2MHz, clk_1MHz, clk_500kHz, clk_250kHz: std_logic := '1';
    signal mod_signal, data, demod_sync_pulse, bit_int: std_logic := '0';
    signal freq_sel, demod_freq, demod_freq_2: freq_state := IDLE;
    signal clk_pow2: std_logic_vector(3 downto 0) := (others => '0');
begin
    clk_100MHz <= not clk_100MHz after 5ns;
    clk_1MHz <= clk_pow2(1);
    clk_500kHz <= clk_pow2(2);
    clk_250kHz <= clk_pow2(3);

    data <= '1' after 0us,  '0' after 4us,  '0' after 8us,  '1' after 12us, '1' after 16us,
            '0' after 20us, '0' after 24us, '1' after 28us, '1' after 32us,  '0' after 36us,
            '0' after 40us;

    clk_div_2MHz: clk_div
        generic map (DIV => 25)
        port map (clk_in => clk_100MHz, clk_out => clk_2MHz);

    clk_div_pow2_N4: clk_div_pow2
        generic map (N => 4)
        port map (clk_in => clk_2MHz, count => clk_pow2);

    frame: frame_builder
        port map (clk_500kHz => clk_500kHz, data => data, freq_sel => freq_sel);

    mod_muxer: mod_mux
        port map (clk_in => clk_500kHz, freq_sel => freq_sel,
                  freq_1 => clk_2MHz, freq_2 => clk_1MHz,
                  freq_out => mod_signal);
    window: window_det
        port map (clk => clk_100MHz, rec => mod_signal, 
                  freq_out => demod_freq, sync_pulse => demod_sync_pulse);
                  
    w_s: window_sync
        port map (clk_100M => clk_100MHz, clk_500k => clk_500kHz,
                  window_state => demod_freq, sync_2M => demod_sync_pulse, 
                  demod_state=>demod_freq_2);
end impl;
