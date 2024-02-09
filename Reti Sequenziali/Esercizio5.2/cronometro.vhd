library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity cronometro is
    port (
        clk : in std_logic;
        enable: in std_logic;
        reset: in std_logic;

        set: in std_logic; --segnale di set unico parallelo e blocca tutti i contatori e permette di caricare gli elementi di ingresso quando alto

        input_hour: in std_logic_vector(4 downto 0);
        input_min: in std_logic_vector(5 downto 0);
        input_sec: in std_logic_vector(5 downto 0);


        hour: out std_logic_vector(4 downto 0);
        min: out std_logic_vector(5 downto 0);
        sec: out std_logic_vector(5 downto 0);


        fullCount : out std_logic
    );
end entity cronometro;



architecture rtl of cronometro is


    component contMod60Secondi is port(
        clk : in std_logic;
        enableContPrimo: in std_logic;
        set: in std_logic;
        input_loaded: in std_logic_vector(5 downto 0);
        reset : in std_logic;

        cont: out std_logic_vector(5 downto 0);
        fullCount: out std_logic
    );
    end component;


   component contMod60 is port(
        clk : in std_logic;
        set: in std_logic;
        input_loaded: in std_logic_vector(5 downto 0);
        reset : in std_logic;

        cont: out std_logic_vector(5 downto 0);
        fullCount: out std_logic
    );
    end component;


    component contMod24 port(
        clk : in std_logic;
        set: in std_logic;
        input_loaded: in std_logic_vector(4 downto 0);
        reset : in std_logic;

        cont: out std_logic_vector(4 downto 0);
        fullCount: out std_logic
    );
    end component;

    signal sectoMin: std_logic;
    signal minToHour: std_logic;
    signal hourToexit:std_logic;
    
    signal secMidi: std_logic_vector(5 downto 0);
    signal minMidi: std_logic_vector(5 downto 0);
    signal hourMidi: std_logic_vector(4 downto 0);
    
begin

    seconds: contMod60Secondi port map(
        clk=>clk,
        enableContPrimo=> enable,
        set => set,
        input_loaded => input_sec,
        reset => reset,

        cont => secMidi,
        fullCount=> sectoMin

    );

    mins: contMod60 port map(
        clk=> sectoMin,
        set=> set,
        input_loaded => input_min,
        reset => reset, 

        cont=> minMidi,
        fullCount=>minToHour

    );

    hours: contMod24 port map(
        clk=> minToHour,
        set => set, 
        input_loaded => input_hour,
        reset => reset, 

        cont => hourMidi, 
        fullCount => hourtoExit
    );
    
    hour <= hourMidi;
    min<= minMidi;
    sec<= secMidi;
    
    fullCount<= '1' when (hourMidi="10111" AND minMidi="111011" AND secMidi="111011") else 
                '0';
    

end architecture rtl;