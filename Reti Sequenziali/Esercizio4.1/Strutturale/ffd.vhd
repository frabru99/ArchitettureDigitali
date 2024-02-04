library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ffd is
    port (
        D : in std_logic;
        clk: in std_logic;
        reset: in std_logic;

        Q : out std_logic
    );
end entity ffd;


architecture comportamentale of ffd is
    
begin
    
    proc_name: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                Q<='0'; --reset sincrono
            else 
                Q<=D;
            end if;

        end if;
    end process proc_name;
    
    
end architecture comportamentale;