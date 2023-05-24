
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity problema1 is
generic(N : natural := 8);
port (clk: in std_logic;
		rst: in std_logic;
		njr: in std_logic;
		q:	 out std_logic_vector(N-1 downto 0)
		);
end entity;

architecture arch_problema1 of problema1 is

signal st_a , st_f : std_logic_vector(N-1 downto 0);
signal s_i : std_logic;
begin

memoria: process(clk, rst)
	begin
		
		if(rst = '1') then
			st_a(0) <= '1';
			st_a(N-1 downto 1) <= (others => '0');
		elsif(rising_edge(clk)) then
			
			st_a <= st_f;

		end if;

end process;

s_i <= st_a(N-1) when njr = '1' else not(st_a(N-1));
st_f <= st_a(N-2 downto 0) & s_i;
q <= st_a; 

-- Pongo el valor inicial en 1 para que ambos contadores inicien en la misma secuencia, y no queden en estados bloqueantes.
-- Si el anillo arranca en 0, no cuenta nada.
end arch_problema1;

