library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity mux_16_1 is
    port (
        input_16_1: in STD_LOGIC_VECTOR (0 to 15);
        
        control_16_1: in STD_LOGIC_VECTOR (0 to 3);

        y_16_1: out STD_LOGIC
        
    );
end entity mux_16_1;


architecture structural of mux_16_1 is

    

    signal outputs: STD_LOGIC_VECTOR (0 to 3) :=  (others => '0'); --uscite dei 4 multiplexer da interconnettere

    component mux_4_1 port(

        input_4_1 : in STD_LOGIC_VECTOR (0 to 3);

        control_4_1 : in STD_LOGIC_VECTOR (0 to 1);

        y_4_1 : out STD_LOGIC 

    );
    end component;
    
begin

    mux0: mux_4_1 
                Port map (
                    input_4_1(0) => input_16_1(0), 
                    input_4_1(1) => input_16_1(1), 
                    input_4_1(2) => input_16_1(2), 
                    input_4_1(3) => input_16_1(3), 

                    control_4_1(0) => control_16_1(0),
                    control_4_1(1) => control_16_1(1),


                    y_4_1 => outputs(0)
                );

    mux1: mux_4_1 
                Port map (
                    input_4_1(0) => input_16_1(4), 
                    input_4_1(1) => input_16_1(5), 
                    input_4_1(2) => input_16_1(6), 
                    input_4_1(3) => input_16_1(7),

                    control_4_1(0) => control_16_1(0),
                    control_4_1(1) => control_16_1(1),
                    
                    y_4_1 => outputs(1)
                );


    mux2: mux_4_1 
                Port map (
                    input_4_1(0) => input_16_1(8), 
                    input_4_1(1) => input_16_1(9), 
                    input_4_1(2) => input_16_1(10), 
                    input_4_1(3) => input_16_1(11),

                    control_4_1(0) => control_16_1(0),
                    control_4_1(1) => control_16_1(1),

                    y_4_1 => outputs(2)
                );

    mux3: mux_4_1 
                Port map (
                    input_4_1(0) => input_16_1(12), 
                    input_4_1(1) => input_16_1(13), 
                    input_4_1(2) => input_16_1(14), 
                    input_4_1(3) => input_16_1(15),


                    control_4_1(0) => control_16_1(0),
                    control_4_1(1) => control_16_1(1),

                    y_4_1 => outputs(3)

                );


    mux4: mux_4_1 
                Port map (
                    input_4_1(0) => outputs(0), 
                    input_4_1(1) => outputs(1), 
                    input_4_1(2) => outputs(2), 
                    input_4_1(3) => outputs(3),


                    control_4_1(0) => control_16_1(2),
                    control_4_1(1) => control_16_1(3),

                    y_4_1 => y_16_1

                );


    
    
    
end architecture structural;