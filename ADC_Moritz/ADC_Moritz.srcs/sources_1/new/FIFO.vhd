----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2018 10:05:50
-- Design Name: 
-- Module Name: FIFO - Behavioral
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

use IEEE.STD_Logic_arith.all;
use IEEE.Std_logic_unsigned.all;


entity FIFO is
Port (
    d_in : in STD_LOGIC_VECTOR (8 downto 0);
    drdy : in STD_LOGIC;
    CLK250kHz : in STD_LOGIC;
    d_out : out STD_LOGIC_VECTOR (8 downto 0)
    );
end FIFO;

architecture Behavioral of FIFO is

signal adr_read : std_logic_vector(7 downto 0) := (others=>'0');
signal adr_write : std_logic_vector(7 downto 0) := (others=>'0');
signal CLK25kHz : std_logic := '0';
signal count : std_logic_vector(3 downto 0) := (others=>'0');
	
TYPE ram_type IS array(255 downto 0) OF std_logic_vector(8 downto 0);
signal sigram : ram_type := (others=>"000000000");
	
begin

x99: process (CLK250kHz)
begin
    if rising_edge(CLK250kHz) then
        count <= count + 1;
        if count = 9 then
            count <= "0000";
            CLK25kHz <= not CLK25kHz;
        end if;
    end if;
end process;

x1: process (drdy)
begin
    if rising_edge (drdy) then
        adr_write <= adr_write + 1;
        sigram(conv_integer(adr_write)) <= d_in;
    end if;
end process;

x2: process (CLK25kHz)
begin
    if rising_edge(CLK25kHz) then
        adr_read <= adr_read + 2;
        d_out <= sigram(conv_integer(adr_read));
    end if;
end process;

end Behavioral;


