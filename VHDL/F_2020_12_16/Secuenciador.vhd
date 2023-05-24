
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- 10Mhz --> 10M tick = 1 seg
-- log2(10M) = 23,25 -> 24 bits necesarios
Entity Secuenciador is
generic(N: NATURAL := 24);
port(
	piClk : in std_logic;
	piRst : in std_logic;
	piEna : in std_logic;
	poLeds : out std_logic_vector(4-1 downto 0)
);
end entity;

architecture arch_Secuenciador of Secuenciador is

signal ct_a, ct_f : unsigned(N-1 downto 0);
signal st_a, st_f : std_logic_vector(4-1 downto 0);
signal sTc : std_logic;
begin

contador: process(piclk)
begin
	if(rising_edge(piclk)) then
		if(piRst = '1' or sTc ='1') then
			ct_a <= (others => '0');
		else
			ct_a <= ct_f;
		end if;
	end if;
end process;

ct_f <= ct_a + 1 when piEna = '1' else ct_a;

sTc <= '1' when ct_a = 10000000 else '0';

leds: process(piClk)
begin
	if(rising_edge(piClk)) then
		if(piRst = '1') then
			st_a <= "0001";
		elsif(sTc = '1') then
			st_a <= st_f;
		end if;
	end if;
end process;

st_f <= st_a(4-2 downto 0) & st_a(4-1);

poLeds <= st_a;

end arch_Secuenciador;

