library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- fclk = 50 MHz
-- fparpadeo = 1 Hz

-- para contar un segundo cuento hasta 50 millones
-- log2(50M) --> 25,57 --> N = 26

entity parpadeo is
	
	generic( N : NATURAL := 26);
	
	port(
		clk : in std_logic;
		rst : in std_logic; 	-- sincronico, activo bajo
		led : out std_logic := '0'
	);
end parpadeo;

architecture archo_parpadeo of parpadeo is
	
	signal scnt_a, scnt_f : unsigned(N-1 downto 0);
	signal stc  : std_logic;

begin
	
	flip_flops:process(clk)
	begin
		if(rising_edge(clk)) then
			
			if(rst = '0' or stc = '1') then
				scnt_a <= (others => '0');		
			else
				scnt_a <= scnt_f;	
			end if;
		end if;
	end process;
	
	scnt_f <= scnt_a + 1;
	stc <= '1' when (scnt_a = 50000000) else '0';
	
	led <= '1' when (stc = '1') else '0';
	
end archo_parpadeo;

