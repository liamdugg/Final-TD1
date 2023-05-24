library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity Fibonacci is

	generic( N: NATURAL := 4);
	port (
		
		clk	:	in		std_logic;
		rst	:	in		std_logic;
		q		:	out	std_logic_vector(N-1 downto 0);
		tc		:	out	std_logic
	);
	
end entity;

architecture Arch_Fibonacci of Fibonacci is

signal s1, s2, s3 :unsigned(N downto 0);
signal sSuma : unsigned(N downto 0);
signal sTc : std_logic;
signal sRst : std_logic;
begin


sRst <= rst or sTc;

sSuma <= s2 + s3;

sTc <= sSuma(N); -- Co de la suma. Si C0 = 1, me quede sin bits para mostrar Num fibonacci correcto
tc <= sTc;

s1 <= sSuma;

memoria: process(clk)
begin
	if(rising_edge(clk)) then	
		if(sRst = '1') then
			s2 <= (others => '0');
			s3(0) <= '1';
			s3(N downto 1) <= (others => '0');
		else
			s2 <= s1; --FF1
			s3 <= s2; --FF2
		end if;
	end if;
end process;

q <= std_logic_vector(s2(N-1 downto 0));

end Arch_Fibonacci;

