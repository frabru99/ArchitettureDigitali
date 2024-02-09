library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity fftClassic is
    port (
        clk : in std_logic;
        reset : in std_logic; --reset dato esternamente

        
        Y : out std_logic

    );
end entity fftClassic;


architecture rtl of fftClassic is

    signal T : std_logic :='0';
    
begin
    ff: process (clk, reset)
    begin
        if (reset='1') then
            T<='0';
        elsif falling_edge(clk) then
                T<= not T;
        end if;
    end process;

Y<=T; --assegnazione di T a Y

end architecture rtl;