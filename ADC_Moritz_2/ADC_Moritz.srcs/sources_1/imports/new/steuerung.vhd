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
library UNISIM;
use UNISIM.VComponents.all;

entity steuerung is port (
--daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
--den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
--di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
--dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
--do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
--drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
--dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
--reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
vauxn3          : in  STD_LOGIC;
--busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
--channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
--eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
--eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
--alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
--vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
--vn_in           : in  STD_LOGIC;

SW  : in STD_LOGIC;
LED1 : out STD_LOGIC;
LED2 : out STD_LOGIC;
CLK100MHZ : in STD_LOGIC;
AUD_PWM : out STD_LOGIC;
AUD_SD : out STD_LOGIC      -- Audio-Ausgangsverstaerker
);
end steuerung;

architecture Behavioral of steuerung is

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

component PWM is port(
    CLK100MHZ : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR (8 downto 0);
    PWM_out : out STD_LOGIC;
    counter_out  : out STD_LOGIC_VECTOR (8 downto 0)
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
signal busy_out_sig : std_logic := '0';
signal channel_out_sig : STD_LOGIC_VECTOR (4 downto 0) := "00000";
signal eoc_out_sig : std_logic := '0';
signal eos_out_sig : std_logic := '0';
signal alarm_out_sig : std_logic := '0';
signal vp_in_sig : std_logic := '0';
signal vn_in_sig : std_logic := '0';

signal counter_out_sig : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
signal di_PWM_sig : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
signal PWM_out_sig : std_logic := '0';

begin

x1: xadc_wiz_0 PORT MAP(
    daddr_in        => daddr_in_sig,
    den_in          => den_in_sig,
    di_in           => di_in_sig,
    dwe_in          => dwe_in_sig,          -- low fuer lesen
    do_out          => do_out_sig,          -- Daten des ADC
    drdy_out        => drdy_out_sig,        -- high wenn Daten valide
    dclk_in         => dclk_in_sig,
    reset_in        => reset_in_sig,
    vauxp3          => vauxp3,
    vauxn3          => vauxn3,
    busy_out        => busy_out_sig,
    channel_out     => channel_out_sig,
    eoc_out         => den_in_sig,
    eos_out         => eos_out_sig,
    alarm_out       => alarm_out_sig,
    vp_in           => vp_in_sig,
    vn_in           => vn_in_sig
);

x2: PWM PORT MAP(
    CLK100MHZ   => CLK100MHZ,
    di_in       => di_PWM_sig,
    PWM_out     => PWM_out_sig,
    counter_out => counter_out_sig
);

AUD_PWM <= PWM_out_sig;
LED2 <= PWM_out_sig;

AUD_SD <= '1';
reset_in_sig <= '0';
dwe_in_sig <= '0';
daddr_in_sig <= "0010011";    -- aus3
--daddr_in_sig <= "0010010";      -- aux2
dclk_in_sig <= CLK100MHZ;

--do_out <= do_out_sig;

--LED2 <= SW;
--LED1 <= do_out_sig(9);

x3: process(drdy_out_sig)
begin
    if falling_edge(drdy_out_sig) then
        di_PWM_sig <= do_out_sig(15 downto 7);
    
        if do_out_sig > "0010000000000000" then
            LED1 <= '0';
        else
            LED1 <= '1';
        end if;
    end if;
end process;

end Behavioral;
