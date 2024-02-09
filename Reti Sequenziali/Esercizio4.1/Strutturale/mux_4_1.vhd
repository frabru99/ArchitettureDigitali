

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity mux_4_1 is
    port (

        input_4_1 : in STD_LOGIC_VECTOR (3 downto 0);

        control_4_1 : in STD_LOGIC_VECTOR (1 downto 0);

        y_4_1 : out STD_LOGIC
        
    );
end entity mux_4_1;


architecture dataflow of mux_4_1 is

begin
    y_4_1<= input_4_1(0) when control_4_1="00" else --shift di 1 a sinistra
            input_4_1(1) when control_4_1="01" else --shift di 2 a sinistra
            input_4_1(2) when control_4_1="10" else --shift di 1 a destra
            input_4_1(3) when control_4_1="11" else --shift di 2 a destra
            '0';
    
    
end architecture dataflow;