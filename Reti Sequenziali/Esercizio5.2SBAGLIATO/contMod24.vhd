library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity contMod24 is
    port (
        clk : in std_logic;
        enable: in std_logic;
        set: in std_logic;
        input_loaded: in std_logic_vector(4 downto 0);
        reset : in std_logic;

        cont: out std_logic_vector(4 downto 0);
        fullCount: out std_logic
        
    );
end entity contMod24;


architecture rtl of contMod24 is
    
    

   component fft
        port(
            clk : in std_logic;
            enable: in std_logic;
            reset : in std_logic; --reset dato dall'esterno
            set: in std_logic;
            input_loaded: in std_logic;

            Y : out std_logic
        );
    end component;
        

    signal wirings : std_logic_vector (4 downto 0);
    signal reset_count : std_logic;
    
begin


    ff0: fft port map(
        clk => clk,
        reset => reset_count,
        enable=> enable,
        set => set,
        input_loaded => input_loaded(0),

        Y=> wirings(0)
    );


    gen : for i in 1 to 4 generate 

        ffn: fft port map(
        clk => clk,
        reset => reset_count,
        enable=> wirings(i-1),
        set => set,
        input_loaded => input_loaded(i),

        Y=> wirings(i)
        );
    end generate;

    
    cont <= wirings;
     

    p: process (wirings, clk, reset)
    begin
        fullCount<='1';
        reset_count<='0';
        
        if(wirings = "11000" or reset='1') then
            reset_count<='1';
            
        elsif(wirings = "10111") then 
            fullCount<='0';
        end if;
        
    end process;

end architecture rtl;