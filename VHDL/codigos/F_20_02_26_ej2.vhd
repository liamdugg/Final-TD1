
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity myAlu is
	generic (N : integer := 8);
	
	port(
		a : in std_logic_vector(N-1 downto 0);
		b : in std_logic_vector(N-1 downto 0);
		r : out std_logic_vector(N-1 downto 0);
		ov : out std_logic;
		op :  in std_logic_vector(1 downto 0)
	);
end myAlu;

architecture arch_myAlu of myAlu is

signal sSuma : signed(N-1 downto 0);
signal sResta : signed(N-1 downto 0);
signal sAND : std_logic_vector(N-1 downto 0);
signal sOR : std_logic_vector(N-1 downto 0);
signal sOut : signed(N-1 downto 0);
signal sOv : std_logic;
signal sAux: std_logic;

begin

sSuma <= signed(a) + signed(b);
sResta <= signed(a) - signed(b);
sAND <= a and b;
sOR <= a or b;


sAux <=	(a(N-1) and B(N-1)and not(sSuma(N-1))) or
			(not(a(N-1)) and not(B(N-1)) and sResta(N-1));


with op select
	sOut <=	sSuma				when "00",
				sResta			when "01",
				signed(sAND)	when "10",
				signed(sOR)	when OTHERS;

with op(1) select
	sOv <= sAux when '0',
			 '0'	when others;

r <= std_logic_vector(sOut);
ov <= sOv;
end arch_myAlu;

