library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity fftPrimo is
    port (
        clk : in std_logic;
        enableFirst: in std_logic;
        reset : in std_logic; --reset dato esternamente
        set: in std_logic;
        input_loaded: in std_logic;

        Y : out std_logic

    );
end entity fftPrimo;


architecture rtl of fftPrimo is

    signal T : std_logic :='0';
    
begin
    ff: process (clk)
    begin
        
        if(set='1') then 
            T<=input_loaded;
        elsif (reset='1') then
            T<='0';
        elsif falling_edge(enableFirst) then

            if(set='0') then 
                T<= not T;
              end if;
        end if;
    end process;

Y<=T; --assegnazione di T a Y

end architecture rtl;