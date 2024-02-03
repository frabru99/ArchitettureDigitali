

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity componentM is
    port (

        input_M : in std_logic_vector(7 downto 0);
        output_M: out std_logic_vector(3 downto 0);
        selection: in std_logic
        
    );
end entity componentM;

architecture dataflow of componentM is
    
begin

        output_M <= input_M(3 downto 0) when selection = '0' else  --i primi valori
                    input_M (7 downto 4) when selection = '1' else  -- i secondi
                    "----";    
    
end architecture dataflow;

