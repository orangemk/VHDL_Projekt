----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2018 10:47:26
-- Design Name: 
-- Module Name: S2P - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- --------------------------------------------------------------------------------------------

entity S2P is
generic (n : positive := 9);
Port ( 
  seriell_in : in std_logic;
  CLK250kHz : in std_logic;
  sync_in : in std_logic;
  parallel_out : out std_logic_vector(n-1 downto 0)
);
end S2P;

architecture Behavioral of S2P is

signal parallel_sig : std_logic_vector (n-1 downto 0) := (others=>'0');
signal counter : std_logic_vector (3 downto 0) := (others=>'0');

begin

p1: process(CLK250kHz, counter, sync_in)
begin
    if rising_edge(CLK250kHz) then
        parallel_sig(parallel_sig'length-1 downto 1) <= parallel_sig(parallel_sig'length-2 downto 0);
        parallel_sig(0) <= seriell_in;
        counter <= counter + 1;

        if sync_in = '1' then
            counter <= (others=>'0');
        end if;
         
        if counter = 9 then
            parallel_out <= parallel_sig;
        end if;
     end if;
end process;

end Behavioral;


