library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity cronometro is
    port (
        clk : in std_logic;
        reset: in std_logic;
        set: in std_logic;
        input_loaded: in std_logic_vector(16 downto 0); --ore, minuti, secondi

        hour: out std_logic_vector(4 downto 0);
        min: out std_logic_vector(5 downto 0);
        sec: out std_logic_vector(5 downto 0);
        fullCount : out std_logic

        
    );
end entity cronometro;



architecture rtl of cronometro is


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

    seconds: contMod60 port map(
        clk=>clk,
        set => set,
        input_loaded => input_loaded(5 downto 0),
        reset => reset,

        cont => secMidi,
        fullCount=> sectoMin

    );

    mins: contMod60 port map(
        clk=> sectoMin,
        set=> set,
        input_loaded => input_loaded(11 downto 6),
        reset => reset, 

        cont=> minMidi,
        fullCount=>minToHour

    );

    hours: contMod24 port map(
        clk=> minToHour,
        set => set, 
        input_loaded => input_loaded(16 downto 12),
        reset => reset, 

        cont => hourMidi, 
        fullCount => hourtoExit
    );
    
    hour <= hourMidi;
    min<=minMidi;
    sec<=secMidi;
    
    fullCount<= '1' when (hourMidi="10111" AND minMidi="111011" AND secMidi="111011") AND rising_edge(clk) else 
                '0';
    

end architecture rtl;