library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity loader is
    port (
        input_switch : in std_logic_vector(5 downto 0);
        selection_input: in std_logic_vector(1 downto 0);
        
       

        output_switch: out std_logic_vector(16 downto 0)
        
    );
end entity loader;

architecture rtl of loader is
    
begin
        
       
            output_switch(16 downto 12)<= input_switch(4 downto 0) when selection_input="01"; -- sto caricando le ore
            output_switch(11 downto 6)<= input_switch when selection_input="10"; --sto caricando i minuti
            output_switch(5 downto 0)<= input_switch when selection_input="11"; --sto caricando i secondi
        
end architecture rtl;