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

component xadc_wiz_0 is port(
 daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
 den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
 di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
 dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
 do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
 drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
 dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
 reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
 vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
 vauxn3          : in  STD_LOGIC;
 busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
 channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
 eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
 eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
 alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
 vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
 vn_in           : in  STD_LOGIC
);
end component;

signal aa : std_logic := '0';
signal bb : std_logic := '0';
signal yy : std_logic := '0';

begin

x1: steuerung PORT MAP(
    a => aa,
    b => bb,
    y => yy);
    
aa <=    '0' after 0ms,
        '0' after 10ms,
        '1' after 20ms,
        '1' after 30ms;
        
bb <=    '0' after 0ms,
        '1' after 10ms,
        '0' after 20ms,
        '1' after 30ms;

end Behavioral;

