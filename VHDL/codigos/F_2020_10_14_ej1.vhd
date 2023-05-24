
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;


-- periodo_clk = 10ns
-- periodo salida = 100ns
-- tick = 10
-- modulo = 10
-- N bits necesarios = 4
entity myGenCnt is

port(
	clk: 	in std_logic;
	rst:	in std_logic;
	q:		out std_logic_vector(2 downto 0)
);
end entity;

architecture arch_myGenCnt of myGenCnt is

signal sTc : std_logic;
type TSTATE is (EST_A, EST_B, EST_C, EST_D);


signal st_a, st_f : TSTATE;

begin

-- contador modulo 10
Ins_counter : entity work.contador(arch_contador)
port map
(
		piclk => clk,
		Tc => sTc	
);

memoria : process(clk)
begin
	if(rising_edge(clk)) then
		if(rst = '1') then
			st_a <= EST_A;
		else
			st_a <= st_f;
		end if;
	end if;
end process;

maquina: process(clk, st_a, sTc)
begin
st_f <= st_a;
	CASE st_a IS
		WHEN EST_A =>
			q <= "000";
			if(sTc = '1')then
				st_f <= EST_B;
			end if;
			
		WHEN EST_B =>
			q <= "100";
			if(sTc = '1')then
				st_f <= EST_C;
			end if;
		
		WHEN EST_C =>
			q <= "010";
			if(sTc = '1')then
				st_f <= EST_D;
			end if;
		
		WHEN EST_D =>
			q <= "111";
			if(sTc = '1')then
				st_f <= EST_A;
			end if;
		
		WHEN OTHERS =>
				st_f <= EST_A;
		
		end CASE;
end process;
		
end architecture;

