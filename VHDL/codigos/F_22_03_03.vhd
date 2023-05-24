library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Entity ContadorModProg is
Generic(N: NATURAL := 4);
Port(
	piClk : in std_logic;
	piRst : in std_logic;
	piMod : in std_logic_vector(N-1 downto 0);
	poTc : out std_logic;
	poQ : out std_logic_vector(N-1 downto 0)
);
end ContadorModProg;

architecture Arch_ContadorModProg of ContadorModProg is

signal st_a, st_f: unsigned(N-1 downto 0);
signal sTc: std_logic;

begin

memoria: process(piClk)
	begin
	
	if(rising_edge(piClk)) then	
		if(piRst = '1') then
			st_a <= (others => '0');
		else
			st_a <= st_f;
		end if;
	end if;
end process;

WITH sTc SELECT
	st_f	<=	(st_a + 1) WHEN '0',
				(others => '0') WHEN OTHERS;

sTc <= '1' when st_a = unsigned(piMod) - 1 else '0';

poQ <= std_logic_vector(st_a);
poTc	<= sTc;
end architecture;

