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


    component contatoreB is generic(
        k: integer;
        max_count: integer
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        set: in std_logic;
        input_to_load: in std_logic_vector(k downto 0);
        enable: in std_logic;

        counter_out: out std_logic_vector(k downto 0);
        divider: out std_logic 

    );
    end component;
    
    signal sectoMin: std_logic;
    signal minToHour: std_logic;
    signal hourToexit: std_logic;
    
    
    
begin

    seconds: contatoreB
    generic map (
        k=> 5,
        max_count=> 59
    )
    port map(
        clk=> clk, 
        reset=> reset,
        set=> set,
        input_to_load=> input_sec,
        enable => enable,
        counter_out=> sec,
        divider=> sectoMin
    );

    mins: contatoreB
    generic map (
        k=> 5,
        max_count=> 59
    )
    port map(
        clk=> clk, 
        reset=> reset,
        set=> set,
        input_to_load=> input_min,
        enable => sectoMin,
        counter_out=> min,
        divider=> minToHour
    );

    hours: contatoreB
    generic map (
        k=> 4,
        max_count=> 23
    )
    port map(
        clk=> clk, 
        reset=> reset,
        set=> set,
        input_to_load=> input_hour,
        enable => minToHour,
        counter_out=> hour,
        divider=> fullCount
    );
    

end architecture rtl;