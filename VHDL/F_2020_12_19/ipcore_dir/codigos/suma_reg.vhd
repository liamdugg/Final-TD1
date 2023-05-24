library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity suma_reg is
generic(N : NATURAL := 16);
port(
	i_clk: 	in std_logic;
	i_arst: 	in	std_logic;
	i_add:	in std_logic;
	i_source:in	std_logic_vector(2-1 downto 0);
	i_dest:	in std_logic_vector(2-1 downto 0);
	i_data:	in std_logic_vector(N-1 downto 0);
	
	o_r0,o_r1,o_r2,o_r3 : out std_logic_vector(N-1 downto 0);
	o_carry:	out std_logic
);

end suma_reg;

architecture arch_suma_reg of suma_reg is

signal r0_a, r0_f: unsigned(N downto 0);
signal r1_a, r1_f: unsigned(N downto 0);
signal r2_a, r2_f: unsigned(N downto 0);
signal r3_a, r3_f: unsigned(N downto 0);

signal sData : unsigned(N downto 0);

signal c_a, c_f :std_logic;

signal sSum: unsigned(N downto 0);

begin

sData <= unsigned('0' & i_data);

memoria : process(i_clk,i_arst)
begin
	if(i_arst = '1') then
		r0_a <= (others => '0');
		r1_a <= (others => '0');
		r2_a <= (others => '0');
		r3_a <= (others => '0');
	elsif(rising_edge(i_clk)) then
		if(i_add = '1') then
			r0_a <= r0_f;
			r1_a <= r1_f;
			r2_a <= r2_f;
			r3_a <= r3_f;
		end if;
	end if;
end process;

with i_source select
	sSum	<= sData + r0_a when "00",
				sData + r1_a when "01",
				sData + r2_a when "10",
				sData + r3_a when others;


carry : process(i_clk,i_arst)
begin
	if(i_arst = '1') then
		c_a <= '0';
	elsif(rising_edge(i_clk)) then
		c_a <= c_f;
	end if;
end process;

c_f <= sSum(N);

-- destino

r0_f <= sSUM when i_dest = "00" else r0_a;
r1_f <= sSUM when i_dest = "01" else r1_a;
r2_f <= sSUM when i_dest = "10" else r2_a;
r3_f <= sSUM when i_dest = "11" else r3_a;

o_r0 <= std_logic_vector(r0_a(N-1 downto 0));
o_r1 <= std_logic_vector(r1_a(N-1 downto 0));
o_r2 <= std_logic_vector(r2_a(N-1 downto 0));
o_r3 <= std_logic_vector(r3_a(N-1 downto 0));

o_carry <= c_a;

end arch_suma_reg;

