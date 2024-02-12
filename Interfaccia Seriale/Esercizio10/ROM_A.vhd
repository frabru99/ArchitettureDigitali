
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ROM is
    port (
        output : out std_logic_vector(7 downto 0);

        address : in std_logic_vector(2 downto 0)
    );
end entity ROM;



architecture dataflow of ROM is

    TYPE ROM_8_8 IS ARRAY (0 to 7) of std_logic_vector(0 to 7); --dichiaro il tipo ROM formato da un array di array
    
    constant MEMORY_8_8 : ROM_8_8 := (
        x"00",
        x"01", 
        x"02",
        x"03",
        x"04",
        x"05",
        x"06",
        x"07"
    );


begin


    main: process(address)
    begin
        output <= MEMORY_8_8(to_integer(unsigned(address))) ;
    end process main;


end architecture dataflow;
