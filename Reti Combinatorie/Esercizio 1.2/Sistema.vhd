
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Sistema is
    port (
        input_16_4 : in std_logic_vector(0 to 15);

        output_16_4: out std_logic_vector(0 to 3);

        control_16_1_sis: in std_logic_vector(0 to 3);

        control_1_4_sis: in std_logic_vector(0 to 1)
        
    );
end entity Sistema;

architecture structural of Sistema is

    signal output : std_logic;

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

    

    mux: mux_16_1 port map(
        input_16_1(0) => input_16_4(0),
        input_16_1(1) => input_16_4(1),
        input_16_1(2) => input_16_4(2),
        input_16_1(3) => input_16_4(3),
        input_16_1(4) => input_16_4(4),
        input_16_1(5) => input_16_4(5),
        input_16_1(6) => input_16_4(6),
        input_16_1(7) => input_16_4(7),
        input_16_1(8) => input_16_4(8),
        input_16_1(9) => input_16_4(9),
        input_16_1(10) => input_16_4(10),
        input_16_1(11) => input_16_4(11),
        input_16_1(12) => input_16_4(12),
        input_16_1(13) => input_16_4(13),
        input_16_1(14) => input_16_4(14),
        input_16_1(15) => input_16_4(15),


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