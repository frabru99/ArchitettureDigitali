
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multi is
    port (
        a0 : in STD_LOGIC;
        a1 : in STD_LOGIC;
        
        s  : in STD_LOGIC;
        y  : out STD_LOGIC --filo singolo, possiamo anche definire un bus di fili (STD_LOGIC_VECTOR)
    );
end entity multi;

architecture intermediate of multi is
    
begin
    y <= a0 when s='0' else --input mux precedente 
         a1 when s='1' else --input 
        '-'; 
end architecture intermediate;

