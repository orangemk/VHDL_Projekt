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
vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
vauxn3          : in  STD_LOGIC;
SW  : in STD_LOGIC;
LED1 : out STD_LOGIC;
LED2 : out STD_LOGIC;
CLK100MHZ : in STD_LOGIC;
AUD_PWM : out STD_LOGIC;
AUD_SD : out STD_LOGIC      -- Audio-Ausgangsverstaerker

);
end component;

signal daddr_in_sig : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal den_in_sig : std_logic := '0';
signal di_in_sig : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal dwe_in_sig : STD_LOGIC := '0';
signal do_out_sig : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal drdy_out_sig : std_logic := '0';
signal dclk_in_sig : STD_LOGIC := '0';
signal reset_in_sig : std_logic := '0';
signal vauxp3_sig : std_logic := '0';
signal vauxn3_sig : std_logic := '0';
--signal busy_out_sig : std_logic := '0';
--signal channel_out_sig : STD_LOGIC_VECTOR (4 downto 0) := "00000";
--signal eoc_out_sig : std_logic := '0';
--signal eos_out_sig : std_logic := '0';
--signal alarm_out_sig : std_logic := '0';
--signal vp_in_sig : std_logic := '0';
--signal vn_in_sig : std_logic := '0';

signal CLK100MHZ_sig : std_logic := '0';
signal SW_sig : std_logic := '0';
signal LED1_sig : std_logic := '0';
signal LED2_sig : std_logic := '0';
Signal aud_PWM_sig :std_logic :='0';
SIgnal sd_pwm_sig :std_logic :='0';

begin

x1: steuerung PORT MAP(
--do_out          => do_out_sig,          -- Daten des ADC
--drdy_out        => drdy_out_sig,        -- high wenn Daten valide
--dclk_in         => dclk_in_sig,
--reset_in        => '0',
vauxp3          => vauxp3_sig,
vauxn3          => vauxn3_sig,
--busy_out        => busy_out_sig,
--channel_out     => channel_out_sig,
--eoc_out         => den_in_sig,
--eos_out         => eos_out_sig,
--alarm_out       => alarm_out_sig,
--vp_in           => vp_in_sig,
--vn_in           => vn_in_sig,

SW  => SW_sig,
LED1 => LED1_sig,
LED2 => LED2_sig,
CLK100MHZ => CLK100MHZ_sig,
AUD_PWM =>aud_PWM_sig,
AUD_SD=>sd_pwm_sig    -- Audio-Ausgangsverstaerker

);

CLK100MHZ_sig <=    not CLK100MHZ_sig after 5ns;
daddr_in_sig <= "0010011";

end Behavioral;
