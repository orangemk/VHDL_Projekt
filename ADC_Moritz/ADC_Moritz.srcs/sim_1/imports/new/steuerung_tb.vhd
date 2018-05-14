----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2018 15:30:42
-- Design Name: 
-- Module Name: steuerung_tb - Behavioral
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

entity steuerung_tb is
--  Port ( );
end steuerung_tb;

architecture Behavioral of steuerung_tb is

component steuerung is port(
CLK100MHZ : in STD_LOGIC;
vauxp3    : in STD_LOGIC;    -- Auxiliary Channel 3
vauxn3    : in STD_LOGIC;
BTNU      : in STD_LOGIC;
BTND      : in STD_LOGIC;
AN        : out STD_LOGIC_VECTOR (7 downto 0);
SEG       : out STD_LOGIC_VECTOR (7 downto 0);
AUD_PWM   : out STD_LOGIC;
AUD_SD    : out STD_LOGIC     -- Audio-Ausgangsverstaerker
);
end component;

signal CLK100MHZ_sig : std_logic := '0';
signal vauxp3_sig : std_logic := '0';
signal vauxn3_sig : std_logic := '0';
signal BTNU_sig : std_logic := '0';
signal BTND_sig : std_logic := '0';
SIgnal AN_sig : std_logic_vector (7 downto 0) := (others=>'0');
SIgnal SEG_SD_sig : std_logic_vector (7 downto 0) := (others=>'0');
Signal AUD_PWM_sig : std_logic :='0';
SIgnal AUD_SD_sig : std_logic :='0';

begin

x1: steuerung PORT MAP(
  CLK100MHZ   => CLK100MHZ_sig,
  vauxp3      => vauxp3_sig,
  vauxn3      => vauxn3_sig,
  BTNU        => BTNU_sig,
  BTND        => BTND_sig,
  AN          => AN_sig,
  SEG         => SEG_SD_sig,
  AUD_PWM     => AUD_PWM_sig,
  AUD_SD      => AUD_SD_sig
);

CLK100MHZ_sig <=    not CLK100MHZ_sig after 5ns;

end Behavioral;
