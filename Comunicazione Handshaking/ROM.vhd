
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--ROM PER IL SISTEMA A


entity ROM is
    port (
        output : out std_logic_vector(8 downto 0);

        address : in std_logic_vector(3 downto 0);
        read : in std_logic
    );
end entity ROM;



architecture dataflow of ROM is

    TYPE ROM_16_8 IS ARRAY (0 to 15) of std_logic_vector(8 downto 0); --dichiaro il tipo ROM formato da un array di array
    
    constant MEMORY_16_4 : ROM_16_8 := (
        "0" & x"00",
        "0" & x"01", 
        "0" & x"02",
        "0" & x"03",
        "0" & x"04",
        "0" & x"05",
        "0" & x"06",
        "0" & x"07",
        "0" & x"08",
        "0" & x"09",
        "0" & x"0a",
        "0" & x"0b",
        "0" & x"0c",
        "0" & x"0d",
        "0" & x"0e",
        "0" & x"0f"
    );


begin


    main: process(read)
    begin
        if(falling_edge(read)) then 
            output <= MEMORY_16_4(to_integer(unsigned(address)));
        end if;
    end process main;


end architecture dataflow;
