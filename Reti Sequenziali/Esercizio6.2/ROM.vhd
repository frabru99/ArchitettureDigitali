
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ROM is
    port (
        output : out std_logic_vector(7 downto 0);


        address : in std_logic_vector(3 downto 0);
        read : in std_logic
    );
end entity ROM;



architecture dataflow of ROM is

    TYPE ROM_16_8 IS ARRAY (0 to 15) of std_logic_vector(7 downto 0); --dichiaro il tipo ROM formato da un array di array
    
    constant MEMORY_16_4 : ROM_16_8 := (
        x"f0",
        x"e1", 
        x"d2",
        x"c3",
        x"b4",
        x"a5",
        x"96",
        x"87",
        x"78",
        x"69",
        x"5a",
        x"4b",
        x"3c",
        x"2d",
        x"1e",
        x"0f"
    );


begin


    main: process(read)
    begin
        if(falling_edge(read)) then 
            output <= MEMORY_16_4(to_integer(unsigned(address)));
        end if;
    end process main;


end architecture dataflow;
