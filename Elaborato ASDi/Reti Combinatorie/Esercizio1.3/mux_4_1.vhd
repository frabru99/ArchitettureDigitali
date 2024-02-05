
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity mux_4_1 is
    port (

        input_4_1 : in STD_LOGIC_VECTOR (0 to 3);

        control_4_1 : in STD_LOGIC_VECTOR (0 to 1);

        y_4_1 : out STD_LOGIC
        
    );
end entity mux_4_1;


architecture dataflow of mux_4_1 is

    
    
begin
    y_4_1<= input_4_1(0) when (control_4_1(1)='0' AND control_4_1(0)='0') else
        input_4_1(1) when (control_4_1(1)='0' AND control_4_1(0)='1') else
        input_4_1(2) when (control_4_1(1)='1' AND control_4_1(0)='0') else
        input_4_1(3) when (control_4_1(1)='1' AND control_4_1(0)='1') else
        '-';
    
    
end architecture dataflow;