library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity registro is
	generic(N: integer := 8);
	port(
		clk		:	in 	std_logic;
		rst		:	in		std_logic;
		entrada	:	in 	std_logic;
		salida	:	out	std_logic_vector(N-1 downto 0)
	);
end entity;

architecture arch_registro of registro is

signal st_a, st_f : std_logic_vector(N-1 downto 0);


begin

-- desplazamiento de datos con cada ciclo de clock
memoria : process(clk)
begin
	if (rising_edge(clk)) then
		if(rst = '0') then
			st_a <= (others=>'0');
		else
			st_a <= st_f;
		end if;
	end if;
end process;

st_f <= st_a(N-2 downto 0) & entrada;
salida <= st_a;
end architecture;

