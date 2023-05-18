library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binarioGray is

	generic (N: integer := 4);
	port(
		gray: out std_logic_vector(N-1 downto 0);
		binario: in std_logic_vector(N-1 downto 0)
	);
end binarioGray;

architecture arch_binarioGray of binarioGray is
	--signal sbin : std_logic_vector(N-1 downto 0);
	--signal sgray : std_logic_vector(N-1 downto 0);

begin
	
	b2g: for i in (N-1) downto 0 generate
		
		case_msb: if i=(N-1) generate
			gray(i) <= binario(i);
			end generate;
		
		case_others: if i/= (N-1) generate
			gray(i) <= binario(i+1) xor binario(i);
			end generate;
			
	end generate;
	
	

end arch_binarioGray;

