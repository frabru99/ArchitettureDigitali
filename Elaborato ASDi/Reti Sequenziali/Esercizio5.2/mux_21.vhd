library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_21 is
	port( zero, enable: in std_logic; 
		  s: in std_logic;
		  y: out std_logic);
end mux_21;

architecture rtl of mux_21 is

	begin
	
	y <= zero when s='0' else 
	     enable when s='1';
		 
    end rtl;

		
		