library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity contMod60Secondi is
    port (
        clk : in std_logic;
        enableContPrimo: in std_logic;
        set: in std_logic;
        input_loaded: in std_logic_vector(5 downto 0);
        reset : in std_logic;

        cont: out std_logic_vector(5 downto 0);
        fullCount: out std_logic
        
    );
end entity contMod60Secondi;


architecture rtl of contMod60Secondi is
    
    

   component fft
        port(
            clk : in std_logic;
            reset : in std_logic; --reset dato dall'esterno
            set: in std_logic;
            input_loaded: in std_logic;

            Y : out std_logic
        );
    end component;


    component fftPrimo port(
        clk : in std_logic;
        enableFirst: in std_logic;
        reset : in std_logic; --reset dato esternamente
        set: in std_logic;
        input_loaded: in std_logic;

        Y : out std_logic
    );
    end component;
        

    signal wirings : std_logic_vector (5 downto 0);
    signal reset_count : std_logic;
    
begin


    ff0: fftPrimo port map(
        clk => clk,
        enableFirst=> enableContPrimo,
        reset => reset_count,
        set => set,
        input_loaded => input_loaded(0),

        Y=> wirings(0)
    );


    gen : for i in 1 to 5 generate 

        ffn: fft port map(
        clk => wirings(i-1),
        reset => reset_count,
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
        
        if(wirings = "111100" or reset='1') then
            reset_count<='1';
            
        end if;
        
        if(wirings = "111100") then 
            fullCount<='0';
        end if;
        
    end process;

end architecture rtl;