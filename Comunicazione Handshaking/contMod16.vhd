library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--contatore per entrambi i sistemi

entity contMod16 is
    generic(
        n_bits : positive :=4
    );
    port (
        clk : in std_logic;
        reset : in std_logic;

        cont: out std_logic_vector(n_bits-1 downto 0) 
    );
end entity contMod16;


architecture rtl of contMod16 is

   component fftClassic
        port(
            clk : in std_logic;
            reset : in std_logic; --reset dato dall'esterno
            
            Y : out std_logic
        );
    end component;
        

    signal wirings : std_logic_vector (n_bits-1 downto 0);
    signal reset_count : std_logic;
    
begin


    ff0: fftClassic port map(
        clk => clk,
        reset => reset_count,

        Y=> wirings(0)
    );


    gen : for i in 1 to n_bits-1 generate 

        ffn: fftClassic port map(
        clk => wirings(i-1),
        reset => reset_count,

        Y=> wirings(i)
        );
    end generate;

    
    cont <= wirings;
     

    p: process (wirings, clk, reset)
    begin
        reset_count<='0';
        
        if(reset='1') then
            reset_count<='1';
            
        end if;
        
    end process;

end architecture rtl;