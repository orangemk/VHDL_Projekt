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
  AUD_SD    : out STD_LOGIC
);
end steuerung;

architecture Behavioral of steuerung is

component transmitter_nf is port(
  CLK100MHZ   : in STD_LOGIC;
  vauxp3      : in  STD_LOGIC;
  vauxn3      : in  STD_LOGIC;
  value_parallel : out std_logic_vector (8 downto 0));
end component;

component receiver_nf is port(
CLK100MHZ : in STD_LOGIC;
CLK25kHz : in std_logic;
BTNU : in STD_LOGIC;
BTND : in STD_LOGIC;
SEG : out STD_LOGIC_VECTOR (7 downto 0);
value_parallel : in STD_LOGIC_VECTOR (8 downto 0);
AUD_PWM     : out STD_LOGIC);
end component;

component timingbox is port (
  CLK100MHZ : in STD_LOGIC;
  CLK25kHZ : out STD_LOGIC;
  PWM_7Seg : out STD_LOGIC);
end component;

signal CLK25kHZ_sig : std_logic := '0';
signal value_parallel_sig : std_logic_vector (8 downto 0) := (others=>'0');
signal PWM_7Seg_sig : std_logic := '0';

begin

c1: transmitter_nf port map(
  CLK100MHZ => CLK100MHZ,
  vauxp3    => vauxp3,
  vauxn3    => vauxn3,
  value_parallel    => value_parallel_sig
);

c2: receiver_nf port map(
  CLK100MHZ => CLK100MHZ,
  CLK25kHz  => CLK25kHZ_sig,
  BTNU      => BTNU,
  BTND      => BTND,
  SEG       => SEG,
  value_parallel => value_parallel_sig,
  AUD_PWM   => AUD_PWM
);

c3: timingbox port map(
  CLK100MHZ => CLK100MHZ,
  CLK25kHZ  => CLK25kHZ_sig,
  PWM_7Seg  => PWM_7Seg_sig
);

AUD_SD <= '1';  -- Audioverstaerker einschalten
AN <= "1111111" & not PWM_7Seg_sig;

end Behavioral;







--signal di_P2S_sig : std_logic_vector (8 downto 0) := (others=>'0');
--signal sync_out_sig : std_logic := '0';
--signal seriell_sig : std_logic := '0';
--signal s2p_snyc_sig : std_logic := '0';
--signal parallel_out_sig : std_logic_vector (8 downto 0) := (others=>'0');


--x103: process (CLK100MHz)
--begin
--    if falling_edge (CLK100MHz) and drdy_out_sig = '1' then
--        PWM_in_sig <= do_out_sig (15 downto 7);
--    end if;
--end process;

--component P2S is
--     generic(n:integer:=9);
--     Port (
--         p_in :in std_logic_vector(n-1 downto 0);
--         CLK :in std_logic;
--         reset : in std_logic;
--         sync_out: out std_logic;
--         s_out: out std_logic);
--end component;

--component S2P is
--    generic( n : positive := 9 );
--    Port ( 
--    seriell_in : in std_logic;
--    CLK : in std_logic;
--    reset : in std_logic;
--    parallel_out : out std_logic_vector(n-1 downto 0);
--    s2p_snyc : out std_logic
--    );
--end component;


--x11: FIFO PORT MAP(
--    d_in        => do_out_sig(15 downto 7),
--    drdy        => drdy_out_sig,
--    CLK250kHz   => clk_250kHz,
--    d_out       => di_PWM_sig
--);

--x4: P2S 
--     generic map(n => 9)
--     Port MAP(
--         p_in   => di_P2S_sig,
--         CLK    => clk_250kHz,
--         reset  => '0',
--         sync_out   => sync_out_sig,
--         s_out  => seriell_sig
--     );

--x100: process(drdy_out_sig)
--begin
--    if falling_edge(drdy_out_sig) then
--        di_P2S_sig <= do_out_sig(15 downto 7);
    
--        if do_out_sig > "0010000000000000" then
--            LED1 <= '0';
--        else
--            LED1 <= '1';
--        end if;
--    end if;
--end process;

--x101: process(s2p_snyc_sig)
--begin
--    if rising_edge(s2p_snyc_sig) then
--        di_PWM_sig <= parallel_out_sig;
--    end if;
--end process;

--x3: S2P 
--    generic map ( n => 9 )
--    Port MAP ( 
--    seriell_in  => seriell_sig,
--    CLK         => clk_250kHz,
--    reset       => '0',
--    parallel_out => parallel_out_sig,
--    s2p_snyc    => s2p_snyc_sig
--    );

