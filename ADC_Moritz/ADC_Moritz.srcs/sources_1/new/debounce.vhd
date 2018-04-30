----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:34:38 05/03/2015 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
	port ( CLK_50MHz : in std_logic; 						--Takt
			 switch_input : in std_logic; 					--prellendes Signal
			 debounced_output : out std_logic := '0'		--entprelltes Signal
		   );
end debounce;

architecture Behavioral of debounce is
	signal count_flag : std_logic:='0'; 					--zeigt einen aktuellen Zählvorgang an
																		--während dieser Zeit wird kein
																		--Eingangssignalwert betrachtet
	signal counter : std_logic_vector(23 downto 0):=(others=>'0');		--Zähler zur Zeitverzögerung
	signal pre_input : std_logic:='0'; 						--vorheriger Signalwert zur Flankendetektion
	
begin

process (CLK_50MHz)
	begin
	if (CLK_50MHz'event and CLK_50MHz='1') then
		pre_input<=switch_input; 								--Folgesignalabspeicherung
																		--wird erst am Ende des Prozesses durchgeführt
		if(count_flag='0')then 									--Zählvorgang ist abgeschlossen
			if(pre_input=switch_input)then 					--hat sich der Eingang geändert?
				debounced_output<=switch_input; 				--Wert ausgeben
				counter<=x"000000"; 								--Zähler initialisieren
			else
				count_flag<= '1'; 								--Zähler aktiv
			end if;
		else
			if (counter = x"2625A0") then 					--Einstellzeit abfragen
				counter<=x"000000"; 								-- x"2625A0" this hex value is 2500000
				count_flag <= '0'; 								-- each cycle is 20 ns at 50 MHz
			else 														-- total time of counter is
				counter <= counter + 1; 						-- 2,500,000 * 20 ns = 50ms
			end if;
		end if;
	end if;
end process;

end Behavioral;


