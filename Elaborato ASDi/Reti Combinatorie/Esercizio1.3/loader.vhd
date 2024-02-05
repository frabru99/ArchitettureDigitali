library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity loader is
    port (
        input_switch : in std_logic_vector(0 to 7);
        button1: in std_logic;
        button2: in std_logic;
        clk: in std_logic;

        output_switch: out std_logic_vector(0 to 15)
        
    );
end entity loader;

architecture rtl of loader is
    
begin



    process (clk)
    begin
        if rising_edge(clk) then
            if(button1='1' AND button2='0') then

                output_switch(0 to 7) <= input_switch;

            elsif(button1='0' AND button2='1') then
                
                output_switch(8 to 15) <= input_switch;
                
            end if;
        end if;
    end process;


    
    
    
end architecture rtl;