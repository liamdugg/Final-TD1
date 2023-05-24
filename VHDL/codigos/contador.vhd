library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- periodo_clk = 10ns
-- periodo salida = 100ns
-- tick = 10
-- modulo = 10
-- N bits necesarios = 4
entity contador is
port(
	piclk: 	in std_logic;
	Tc :		out std_logic
);
end entity;

architecture arch_contador of contador is

signal sCnt, sAct, sFut : unsigned(3 downto 0);
signal sTc: std_logic;

begin

memoria: process(piclk) 
begin
	if(rising_edge(piclk)) then
		if(sTc = '1') then
			sAct <= (others => '0');
		else
			SAct <= SFut; 
		end if;
	end if;
end process;

SFut <= SAct + 1 when sTc = '0' else (others => '0');
sTc <= '1' when SAct = to_unsigned(10,4) else '0';

Tc <= sTc;

end architecture;

