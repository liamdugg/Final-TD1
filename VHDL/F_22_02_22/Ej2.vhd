library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
	
	generic (N: integer := 8);
	
	port(
		clk : in std_logic;
		rst : in std_logic;
		ena : in std_logic;
		cnt : out std_logic_vector(N-1 downto 0) := (others => '0')
	);

end contador;

architecture arch_contador of contador is
	
	signal scnt_a, scnt_f : unsigned(N-1 downto 0);

begin
	
	memoria: process(clk)
	begin

		if(rising_edge(clk)) then
			
			if(rst = '1') then
				scnt_a <= (others => '0');
			
			elsif(rst = '0') then
				scnt_a <= scnt_f;
			end if;
			
		end if;
	end process;
	
	scnt_f <= (scnt_a + 1) when ena = '1' else scnt_a;
	cnt <= std_logic_vector(scnt_a);
	
end arch_contador;

