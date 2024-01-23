

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity componentM is
    port (

        input_M : in std_logic_vector(0 to 7);
        output_M: out std_logic_vector(0 to 3);
        selection: in std_logic
        
    );
end entity componentM;

architecture dataflow of componentM is
    
begin

        output_M <= input_M(0 to 3) when selection = '0' else  --i primin valori
                    input_M (4 to 7) when selection = '1' else  -- i secondi
                    "----";    
    
end architecture dataflow;

