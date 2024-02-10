library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity muxDisplay is
	port( conteggio, memoria: in std_logic_vector(31 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(31 downto 0));
end muxDisplay;

architecture rtl of muxDisplay is

	begin
	
	y <= conteggio when s='0' else --faccio passare il conteggio
	     memoria when s='1'; --faccio passare i valori in uscita dalla memoria
		 
    end rtl;

		
		