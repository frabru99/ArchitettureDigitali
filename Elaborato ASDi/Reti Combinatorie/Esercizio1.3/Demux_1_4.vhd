
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Demux_1_4 is
    port (
        input_1_4: in STD_LOGIC;

        output_1_4: out std_logic_vector(0 to 3);
        
        control_1_4 : in std_logic_vector(0 to 1)
    );
end entity Demux_1_4;


architecture dataflow of Demux_1_4 is
    
begin
    output_1_4(0) <= input_1_4 when control_1_4(1)='0' AND control_1_4(0)='0' else
                     '0';
    output_1_4(1) <= input_1_4 when control_1_4(1)='0' AND control_1_4(0)='1' else
                    '0';
    output_1_4(2) <= input_1_4 when control_1_4(1)='1' AND control_1_4(0)='0' else
                    '0';
    output_1_4(3) <= input_1_4 when control_1_4(1)='1' AND control_1_4(0)='1' else
                    '0';

    
end architecture dataflow;