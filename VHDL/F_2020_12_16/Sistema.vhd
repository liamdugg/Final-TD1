
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


Entity Sistema is
generic(
	N: NATURAL := 4
);
port(
	piClk : in std_logic;
	piRst : in std_logic;
	piEna : in std_logic;
	piMod : in std_logic_vector(N-1 downto 0);
	poQ : out std_logic_vector(N-1 downto 0);
	poTc : out std_logic
); 
end entity;

architecture Arch_Sistema of Sistema is

signal st_a, st_f : unsigned(N-1 downto 0);
signal sTc, sEq, sRst : std_logic;
signal sAux : unsigned(N-1 downto 0);
signal sSum: unsigned(N-1 downto 0);

begin

sSum <= st_a + 1;

memoria : process(piClk)
begin
	if(rising_edge(piClk)) then
		st_a <= st_f;
		sTc <= sEq;
	end if;
end process;
	
sAux <= sSum when piEna = '1' else sSum - 1;

sRst <= piRst or sTc;

st_f <= sAux when sRst = '0' else (others => '0');
	
-- comparador 

sEq <= '1' when st_a = unsigned(piMod) + 1 else '0';

-- salidas
poTc <= sTc;
poQ <= std_logic_vector(st_a);

end Arch_Sistema;

