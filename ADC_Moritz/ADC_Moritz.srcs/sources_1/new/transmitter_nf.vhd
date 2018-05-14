----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2018 14:18:16
-- Design Name: 
-- Module Name: transmitter_nf - Behavioral
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

entity transmitter_nf is port (
  CLK100MHZ    : in std_logic;
  CLK250kHz    : in std_logic;
  vauxp3       : in std_logic;
  vauxn3       : in std_logic;
  sync_out     : out std_logic;
  parallel_out : out std_logic_vector (8 downto 0);
  seriell_out  : out std_logic
);
end transmitter_nf;

architecture Behavioral of transmitter_nf is

component xadc_wiz_0 is port(
  daddr_in    : in std_logic_vector (6 downto 0);     -- Address bus for the dynamic reconfiguration port
  den_in      : in std_logic;                         -- Enable Signal for the dynamic reconfiguration port
  di_in       : in std_logic_vector (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
  dwe_in      : in std_logic;                         -- Write Enable for the dynamic reconfiguration port
  do_out      : out std_logic_vector (15 downto 0);   -- Output data bus for dynamic reconfiguration port
  drdy_out    : out std_logic;                        -- Data ready signal for the dynamic reconfiguration port
  dclk_in     : in std_logic;                         -- Clock input for the dynamic reconfiguration port
  vauxp3      : in std_logic;                         -- Auxiliary Channel 3
  vauxn3      : in std_logic;
  busy_out    : out std_logic;                        -- ADC Busy signal
  channel_out : out std_logic_vector (4 downto 0);    -- Channel Selection Outputs
  eoc_out     : out std_logic;                        -- End of Conversion Signal
  eos_out     : out std_logic;                        -- End of Sequence Signal
  alarm_out   : out std_logic;                         -- OR'ed output of all the Alarms
  vp_in       : in std_logic;                         -- Dedicated Analog Input Pair
  vn_in       : in std_logic
);
end component;

component P2S is 
generic(n : integer := 9);
port (
  parallel_in : in std_logic_vector(n-1 downto 0);
  CLK250kHz   : in std_logic;
  sync_out    : out std_logic;
  seriell_out : out std_logic
);
end component;

signal den_in_sig : std_logic := '0';
signal di_in_sig : std_logic_vector (15 downto 0) := (others=>'0');
signal do_out_sig : std_logic_vector (15 downto 0) := (others=>'0');
signal drdy_out_sig : std_logic := '0';
signal busy_out_sig : std_logic := '0';
signal channel_out_sig : std_logic_vector (4 downto 0) := (others=>'0');
signal eoc_out_sig : std_logic := '0';
signal eos_out_sig : std_logic := '0';
signal alarm_out_sig : std_logic := '0';
signal vp_in_sig : std_logic := '0';
signal vn_in_sig : std_logic := '0';

signal parallel_sig : std_logic_vector (8 downto 0) := (others=>'0');

begin

c1: xadc_wiz_0 port map(
  daddr_in    => "0010011",           -- aux3 ("0010010" fuer aux2)
  den_in      => den_in_sig,
  di_in       => di_in_sig,
  dwe_in      => '0',                 -- low fuer lesen
  do_out      => do_out_sig,          -- Daten des ADC
  drdy_out    => drdy_out_sig,        -- high wenn Daten valide
  dclk_in     => CLK100MHZ,
  vauxp3      => vauxp3,
  vauxn3      => vauxn3,
  busy_out    => busy_out_sig,
  channel_out => channel_out_sig,
  eoc_out     => den_in_sig,
  eos_out     => eos_out_sig,
  alarm_out   => alarm_out_sig,
  vp_in       => vp_in_sig,
  vn_in       => vn_in_sig
);

c2: P2S port map(
  parallel_in => parallel_sig,
  CLK250kHz   => CLK250kHz,
  sync_out    => sync_out,
  seriell_out => seriell_out
);

p1: process(CLK100MHZ, drdy_out_sig)
begin
    if falling_edge(CLK100MHZ) and drdy_out_sig = '1' then
        parallel_sig <= do_out_sig(15 downto 7);
    end if;
end process;

parallel_out <= parallel_sig;

end Behavioral;
