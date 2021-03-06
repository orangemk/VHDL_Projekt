----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2018 14:12:37
-- Design Name: 
-- Module Name: receiver_nf - Behavioral
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

entity receiver_nf is Port (
  CLK100MHZ   : in STD_LOGIC;
  CLK250kHz   : in std_logic;
  CLK25kHz    : in std_logic;
  BTNU        : in STD_LOGIC;
  BTND        : in STD_LOGIC;
  parallel_in : in STD_LOGIC_VECTOR (8 downto 0);
  seriell_in  : in std_logic;
  sync_in     : in std_logic;
  SEG         : out STD_LOGIC_VECTOR (7 downto 0);
  AUD_PWM     : out STD_LOGIC
);
end receiver_nf;

architecture Behavioral of receiver_nf is

component Sieben_Seg_Taster is port( 
  CLK100MHZ : in STD_LOGIC;
  BTNU      : in STD_LOGIC;
  BTND      : in STD_LOGIC;
  count     : out STD_LOGIC_VECTOR (2 downto 0);
  SEG       : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component PWM is port(
  CLK100MHZ     : in STD_LOGIC;
  PWM_in        : in STD_LOGIC_VECTOR (8 downto 0);
  PWM_out       : out STD_LOGIC
);
end component;

component S2P is
generic (n : positive := 9 );
Port ( 
  seriell_in : in std_logic;
  CLK250kHz : in std_logic;
  sync_in : in std_logic;
  parallel_out : out std_logic_vector(n-1 downto 0)
);
end component;

signal PWM_in_sig : std_logic_vector (8 downto 0) := (others=>'0');
signal count_sig : STD_LOGIC_VECTOR (2 downto 0) := (others=>'0');
signal parallel_sig : std_logic_vector (8 downto 0) := (others=>'0');

begin

c1: S2P PORT MAP(
  seriell_in   => seriell_in,
  CLK250kHz    => CLK250kHz,
  sync_in      => sync_in,
  parallel_out => parallel_sig
);

c2: PWM PORT MAP(
  CLK100MHZ   => CLK100MHZ,
  PWM_in      => PWM_in_sig,
  PWM_out     => AUD_PWM
);

c3: Sieben_Seg_Taster port map(
  CLK100MHZ  => CLK100MHZ,
  BTNU       => BTNU,
  BTND       => BTND,
  count      => count_sig,
  SEG        => SEG
);
 
p1: process (CLK25kHz)
begin
if rising_edge (CLK25kHz) then
    case count_sig is
        when "111" => PWM_in_sig <= parallel_sig(8 downto 0);
--        when "110" => PWM_in_sig <= '0' & value_parallel(8 downto 1);
        when "110" => PWM_in_sig <= parallel_in(8 downto 0);
        when "101" => PWM_in_sig <= "00" & parallel_sig(8 downto 2);
        when "100" => PWM_in_sig <= "000" & parallel_sig(8 downto 3);
        when "011" => PWM_in_sig <= "0000" & parallel_sig(8 downto 4);
        when "010" => PWM_in_sig <= "00000" & parallel_sig(8 downto 5);
        when "001" => PWM_in_sig <= "000000" & parallel_sig(8 downto 6);
        when "000" => PWM_in_sig <= "0000000" & parallel_sig(8 downto 7);
        when others => PWM_in_sig <= parallel_sig(8 downto 0);
    end case;
end if;
end process;

end Behavioral;
