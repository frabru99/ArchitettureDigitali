library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AdderStrings is
    port (

        X: in std_logic_vector(8 downto 0);
        Y: in std_logic_vector(8 downto 0);

        start_operation: in std_logic;

        data_out: out std_logic_vector(8 downto 0)

    );
end entity AdderStrings;


architecture rtl of AdderStrings is
    
begin

    process(start_operation)

    begin

        if(rising_edge(start_operation)) then 
            data_out<=std_logic_vector(unsigned(X)+unsigned(Y));
        end if;
        
    end process;

    
end architecture rtl;