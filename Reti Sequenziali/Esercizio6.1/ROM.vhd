
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
        x"00",
        x"01", 
        x"02",
        x"03",
        x"04",
        x"05",
        x"06",
        x"07",
        x"08",
        x"09",
        x"0a",
        x"0b",
        x"0c",
        x"0d",
        x"0e",
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
