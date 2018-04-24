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
use  IEEE.STD_Logic_arith.all;
use IEEE.Std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity P2S is
     generic(n:integer:=9);
     Port (
         p_in :in std_logic_vector(n-1 downto 0);
         ctrl_in : in std_logic;--_vector(1 downto 0);
         CLK :in std_logic;
         reset : in std_logic;
         feedback: out std_logic;
         sync_out: out std_logic;
         s_out: out std_logic;
         p_intern: inout std_logic_vector(n-1 downto 0));
         --counter: inout std_logic_vector(3 downto 0));
end P2S;

architecture Behavioral of P2S is

--signal p_intern: std_logic_vector(n-1 downto 0);
signal counter: std_logic_vector(3 downto 0):=(others=>'0');

begin
    process(clk,reset)
    begin
        if reset = '1' then
            s_out<='0';
            p_intern<=(others=>'0');
            counter<="0000";
        elsif rising_edge(clk)then
            CASE ctrl_in is
                when '0' => p_intern <=p_in;
                            counter <= "0000";
                            s_out<='0';
                            sync_out<='1';
                when '1' => sync_out<='0';
                            s_out<=p_intern(n-1);
                            p_intern(p_intern'length-1 downto 1)<=p_intern(p_intern'length-2 downto 0);
                            p_intern(0)<='0';
                            counter<=counter+1;
                when others =>
            end case;
        end if;
    end process;
    
feedback<=not((counter(0)xnor'1') and (counter(1)xnor'0') and (counter(2)xnor'0') and (counter(3)xnor'1'));
              
         
-- tsync aktivieren pro frame und ctrl_in umschalten
end Behavioral;
