----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2018 19:18:03
-- Design Name: 
-- Module Name: P2S - Behavioral
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
use IEEE.STD_Logic_arith.all;
use IEEE.Std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity P2S is
generic(n : integer := 9);
Port (
  parallel_in : in std_logic_vector(n-1 downto 0);
  CLK250kHz   : in std_logic;
  sync_out    : out std_logic;
  seriell_out : out std_logic);
end P2S;

architecture Behavioral of P2S is

signal ctrl_sig : std_logic := '0';
signal parallel_sig: std_logic_vector(n-1 downto 0);
signal counter: std_logic_vector(3 downto 0):=(others=>'0');

begin
p1: process(CLK250kHz)
begin
    if rising_edge(CLK250kHz) then
        CASE ctrl_sig is
            when '0' => parallel_sig <= parallel_in;
                        counter <= "0000";
                        seriell_out <= '0';
                        sync_out <= '1';
            when '1' => sync_out <= '0';
                        seriell_out <= parallel_sig(n-1);
                        parallel_sig(parallel_sig'length-1 downto 1) <= parallel_sig(parallel_sig'length-2 downto 0);
                        parallel_sig(0) <= '0';
                        counter <= counter + 1;
            when others =>
        end case;
    end if;
end process;

ctrl_sig <= not((counter(0)xnor'1') and (counter(1)xnor'0') and (counter(2)xnor'0') and (counter(3)xnor'1'));
              
end Behavioral;
