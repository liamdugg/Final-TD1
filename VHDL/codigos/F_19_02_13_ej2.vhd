
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity desplazamiento is
	generic(N: NATURAL := 4);
	port(
		data_in : in std_logic_vector(N-1 downto 0);
		data_out: out std_logic_vector(N-1+3 downto 0);
		ctrl: in std_logic_vector(1 downto 0)
	);

end desplazamiento;

architecture arch_desplazamiento of desplazamiento is


signal s_x1, s_x2, s_x4, s_x8 : std_logic_vector(N-1+3 downto 0);

begin

s_x1 <= data_in(N-1)&data_in(N-1)&data_in(N-1)&data_in;
s_x2 <= data_in(N-1)&data_in(N-1)&data_in&'0';
s_x4 <= data_in(N-1)&data_in&"00";
s_x8 <= data_in&"000";

with ctrl select
	data_out <= s_x1 when "00",
					s_x2 when "01",
					s_x4 when "10",
					s_x8 when others;

end arch_desplazamiento;

