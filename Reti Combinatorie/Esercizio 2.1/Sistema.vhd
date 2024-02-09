


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Sistema is
    port (

        controller_mem_sis: in std_logic_vector(0 to 3);

        controller_M_sis : in std_logic;

        output_sis : out std_logic_vector(0 to 3)
        
    );
end entity Sistema;


architecture structural of Sistema is

    signal output_mem : std_logic_vector(0 to 7) := (others => '0');

    component ROM port(
        output : out std_logic_vector(0 to 7);

        address : in std_logic_vector(0 to 3)

    );
    end component;

    component componentM port(

        input_M : in std_logic_vector(0 to 7);
        output_M: out std_logic_vector(0 to 3);
        selection: in std_logic

    );
    end component;
    
begin

    ROM_1 : ROM port map(
            address(0) => controller_mem_sis(0),
            address(1) => controller_mem_sis(1),
            address(2) => controller_mem_sis(2),
            address(3) => controller_mem_sis(3),

            output(0) => output_mem(0),
            output(1) => output_mem(1),
            output(2) => output_mem(2),
            output(3) => output_mem(3),
            output(4) => output_mem(4),
            output(5) => output_mem(5),
            output(6) => output_mem(6),
            output(7) => output_mem(7)

    );

    componentM_1: componentM port map(

        input_M(0) => output_mem(0),
        input_M(1) => output_mem(1),
        input_M(2) => output_mem(2),
        input_M(3) => output_mem(3),
        input_M(4) => output_mem(4),
        input_M(5) => output_mem(5),
        input_M(6) => output_mem(6),
        input_M(7) => output_mem(7),


        output_M(0)=> output_sis(0),
        output_M(1)=> output_sis(1),
        output_M(2)=> output_sis(2),
        output_M(3)=> output_sis(3),


        selection => controller_M_sis

    );

    
    
end architecture structural;