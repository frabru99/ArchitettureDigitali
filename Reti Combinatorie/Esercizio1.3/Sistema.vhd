
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Sistema is
    port (
        clk: in std_logic;

        button1_sis: in std_logic;
        button2_sis: in std_logic;

        input_16_4 : in std_logic_vector(0 to 7); --ingressi dagli switch

        output_16_4: out std_logic_vector(0 to 3);

        control_16_1_sis: in std_logic_vector(0 to 3);

        control_1_4_sis: in std_logic_vector(0 to 1)
        
    );

end entity Sistema;

architecture structural of Sistema is

    signal output : std_logic;
   
    signal loadertoMux: std_logic_vector(0 to 15);

    component loader port (
        input_switch : in std_logic_vector(0 to 7);
        button1: in std_logic;
        button2: in std_logic;
        clk: in std_logic;

        output_switch: out std_logic_vector(0 to 15)
    );
    end component;

    component mux_16_1 port(
        input_16_1: in STD_LOGIC_VECTOR (0 to 15);
        
        control_16_1: in STD_LOGIC_VECTOR (0 to 3);

        y_16_1: out STD_LOGIC

    );
    end component;

    component Demux_1_4 port(
        input_1_4: in STD_LOGIC;

        output_1_4: out std_logic_vector(0 to 3);
        
        control_1_4 : in std_logic_vector(0 to 1)

    );
    end component;
    
begin

    load: loader port map(
        input_switch(0)=> input_16_4(0),
        input_switch(1)=> input_16_4(1),
        input_switch(2)=> input_16_4(2),
        input_switch(3)=> input_16_4(3),
        input_switch(4)=> input_16_4(4),
        input_switch(5)=> input_16_4(5),
        input_switch(6)=> input_16_4(6),
        input_switch(7)=> input_16_4(7),

        button1=> button1_sis,
        button2=> button2_sis,

        clk=> clk, 


        output_switch(0) => loadertoMux(0),
        output_switch(1) => loadertoMux(1),
        output_switch(2) => loadertoMux(2),
        output_switch(3) => loadertoMux(3),
        output_switch(4) => loadertoMux(4),
        output_switch(5) => loadertoMux(5),
        output_switch(6) => loadertoMux(6),
        output_switch(7) => loadertoMux(7),
        output_switch(8) => loadertoMux(8),
        output_switch(9) => loadertoMux(9),
        output_switch(10) => loadertoMux(10),
        output_switch(11) => loadertoMux(11),
        output_switch(12) => loadertoMux(12),
        output_switch(13) => loadertoMux(13),
        output_switch(14) => loadertoMux(14),
        output_switch(15) => loadertoMux(15)


    );

    

    mux: mux_16_1 port map(
        input_16_1(0) => loadertoMux(0),
        input_16_1(1) => loadertoMux(1),
        input_16_1(2) => loadertoMux(2),
        input_16_1(3) => loadertoMux(3),
        input_16_1(4) => loadertoMux(4),
        input_16_1(5) => loadertoMux(5),
        input_16_1(6) => loadertoMux(6),
        input_16_1(7) => loadertoMux(7),
        input_16_1(8) => loadertoMux(8),
        input_16_1(9) => loadertoMux(9),
        input_16_1(10) => loadertoMux(10),
        input_16_1(11) => loadertoMux(11),
        input_16_1(12) => loadertoMux(12),
        input_16_1(13) => loadertoMux(13),
        input_16_1(14) => loadertoMux(14),
        input_16_1(15) => loadertoMux(15),


        --output e controllo

        y_16_1 => output,

        control_16_1(0)=> control_16_1_sis(0),
        control_16_1(1)=> control_16_1_sis(1),
        control_16_1(2)=> control_16_1_sis(2),
        control_16_1(3)=> control_16_1_sis(3)

    );

    demux: Demux_1_4 port map(

        input_1_4 => output,


        output_1_4(0)=> output_16_4(0),
        output_1_4(1) => output_16_4(1),
        output_1_4(2) => output_16_4(2),
        output_1_4(3) => output_16_4(3),


        control_1_4(0) => control_1_4_sis(0),
        control_1_4(1) => control_1_4_sis(1)

    );

    
    
    
end architecture structural;