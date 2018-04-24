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
-- ENTITY
entity S2P is
    generic (
        n : positive := 9
    );
    Port ( 
    seriell_in : in std_logic;
    CLK : in std_logic;
    reset : in std_logic;
    parallel_out : out std_logic_vector(n-1 downto 0);
    s2p_snyc : out std_logic
    );
end S2P;

architecture Behavioral of S2P is

signal parallel_out_tmp : std_logic_vector (n-1 downto 0) := (others=>'0');
signal counter : std_logic_vector (n-1 downto 0) := (others=>'0');

begin

x1: process(clk)
begin
    if rising_edge(clk) then
        s2p_snyc <= '0';

        parallel_out_tmp(parallel_out_tmp'length-1 downto 1)<=parallel_out_tmp(parallel_out_tmp'length-2 downto 0);
        parallel_out_tmp(0) <= seriell_in;
        
        counter <= counter + 1;
        if counter = n then
            counter <= (others=>'0');
            s2p_snyc <= '1';
        end if;
     end if;
end process;

parallel_out <= parallel_out_tmp;

end Behavioral;


