
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity acumulador is

port(
	clk : in std_logic;
	rst : in std_logic; -- sinc, activo bajo
	ena : in std_logic;	-- activo alto
	entrada : in std_logic_vector(8-1 downto 0);
	salida : out std_logic_vector(16-1 downto 0)
);
end acumulador;

architecture arch_acumulador of acumulador is

signal st_a, st_f : unsigned(16-1 downto 0);

begin

memoria : process(clk)
begin
	if(rising_edge(clk)) then
		if(rst = '0') then
			st_a <= (others => '0');
		elsif (ena = '1') then
			st_a <= st_f;
		end if;
	end if;
end process;

st_f <= st_a + unsigned(entrada) when ena = '1' else st_a;

salida <= std_logic_vector(st_a);

end arch_acumulador;

