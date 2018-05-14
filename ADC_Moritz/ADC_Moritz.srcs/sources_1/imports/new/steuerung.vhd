----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2018 15:28:56
-- Design Name: 
-- Module Name: steuerung - Behavioral
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
--use IEEE.Std_logic_unsigned.all;

entity steuerung is port (
  CLK100MHZ : in STD_LOGIC;
  vauxp3    : in STD_LOGIC;
  vauxn3    : in STD_LOGIC;
  BTNU      : in STD_LOGIC;
  BTND      : in STD_LOGIC;
  AN        : out STD_LOGIC_VECTOR (7 downto 0);
  SEG       : out STD_LOGIC_VECTOR (7 downto 0);
  AUD_PWM   : out STD_LOGIC;
  AUD_SD    : out STD_LOGIC;
  JB1       : out std_logic;
  JB2       : in std_logic
);
end steuerung;

architecture Behavioral of steuerung is

component transmitter_nf is port(
  CLK100MHZ    : in STD_LOGIC;
  CLK250kHz    : in STD_LOGIC;
  vauxp3       : in STD_LOGIC;
  vauxn3       : in STD_LOGIC;
  sync_out     : out std_logic;
  parallel_out : out std_logic_vector (8 downto 0);
  seriell_out  : out std_logic);
end component;

component receiver_nf is port(
  CLK100MHZ   : in STD_LOGIC;
  CLK250kHz   : in std_logic;
  CLK25kHz    : in std_logic;
  BTNU        : in STD_LOGIC;
  BTND        : in STD_LOGIC;
  parallel_in : in STD_LOGIC_VECTOR (8 downto 0);
  seriell_in  : in std_logic;
  sync_in     : in std_logic;
  SEG         : out STD_LOGIC_VECTOR (7 downto 0);
  AUD_PWM     : out STD_LOGIC);
end component;

component timingbox is port (
  CLK100MHZ : in STD_LOGIC;
  CLK250kHz : out STD_LOGIC;
  CLK25kHZ  : out STD_LOGIC;
  PWM_7Seg  : out STD_LOGIC);
end component;

signal CLK250kHz_sig : std_logic := '0';
signal CLK25kHZ_sig : std_logic := '0';
signal parallel_sig : std_logic_vector (8 downto 0) := (others=>'0');
signal seriell_sig : std_logic := '0';
signal PWM_7Seg_sig : std_logic := '0';
signal sync_sig : std_logic := '0';

begin

c1: transmitter_nf port map(
  CLK100MHZ => CLK100MHZ,
  CLK250kHz => CLK250kHz_sig,
  vauxp3    => vauxp3,
  vauxn3    => vauxn3,
  sync_out  => sync_sig,
  parallel_out => parallel_sig,
  seriell_out   => JB1
--  seriell_out   => seriell_sig
);

c2: receiver_nf port map(
  CLK100MHZ => CLK100MHZ,
  CLK250kHz => CLK250kHz_sig,
  CLK25kHz  => CLK25kHZ_sig,
  BTNU      => BTNU,
  BTND      => BTND,
  parallel_in => parallel_sig,
  seriell_in => JB2,
--  seriell_in => seriell_sig,
  sync_in      => sync_sig,
  SEG       => SEG,
  AUD_PWM   => AUD_PWM
);

c3: timingbox port map(
  CLK100MHZ => CLK100MHZ,
  CLK250kHz => CLK250kHz_sig,
  CLK25kHZ  => CLK25kHZ_sig,
  PWM_7Seg  => PWM_7Seg_sig
);

AUD_SD <= '1';  -- Audioverstaerker einschalten
AN <= "1111111" & not PWM_7Seg_sig;

end Behavioral;


