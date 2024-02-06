library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sistema_recog is port(
    bottone1_sis: in std_logic; --bottone input
    bottone2_sis: in std_logic;--bottone modo
    bottone3_sis: in std_logic; --bottone reset
    bottone_reset_debouncer: in std_logic;
    clk: in std_logic;
    switchIN: in std_logic;
    switchMODE: in std_logic;
    led_uscita: out std_logic
    );
end sistema_recog;

architecture rtl of sistema_recog is
    
    component riconoscitoristotsparz is port(
        y : out std_logic;
        
        i : in std_logic;
        clk : in std_ulogic;
        reset: in std_logic;
        m: in std_logic;
        
        button1_ric: in std_logic;
        button2_ric: in std_logic
        
        
    );
    end component;

    component ButtonDebouncer is 
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                                -- il valore di default è 10 millisecondi
        );
        port(
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC
        );
     end component;
        

    signal debouncer_to_bottone_recog: std_logic_vector(0 TO 2); --vettore di fili per completare i collegamenti tra i debouncer e il riconoscitore

begin
    
    input: ButtonDebouncer port map(
        RST => bottone_reset_debouncer,
        CLK => clk,
        BTN => bottone1_sis,
        CLEARED_BTN => debouncer_to_bottone_recog(0)
    );

    mode: ButtonDebouncer port map(
        RST => bottone_reset_debouncer,
        CLK => clk,
        BTN => bottone2_sis,
        CLEARED_BTN => debouncer_to_bottone_recog(1)
    );

    reset: ButtonDebouncer port map(
        RST => bottone_reset_debouncer,
        CLK => clk,
        BTN => bottone3_sis,
        CLEARED_BTN => debouncer_to_bottone_recog(2)
    );

    recog: riconoscitoristotsparz port map(
        y => led_uscita,
        i => switchIN,
        clk => clk,
        reset => debouncer_to_bottone_recog(2),
        m => switchMODE, 
        
        button1_ric=> debouncer_to_bottone_recog(0),
        button2_ric=> debouncer_to_bottone_recog(1)
        
    );

end architecture rtl;