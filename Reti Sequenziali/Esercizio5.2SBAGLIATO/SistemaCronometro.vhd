library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity SistemaCronometro is
    port (
        clk : in std_logic;

        input_loaded_sis: in std_logic_vector(5 downto 0); --input degli switch

        button_load_input_sis: in std_logic; --bottone per l'acquisizione 
        button_start_count_sis: in std_logic;
        button_mode_sis: in std_logic; --scegliere lo stato 


        reset: in std_logic;

        anodes_out: out std_logic_vector(7 downto 0);
        cathodes_out : out std_logic_vector(7 downto 0);
        fullCount_uscita: out std_logic;
        
        sec_to_Led: out std_logic_vector(5 downto 0);
        
        setLed: out std_logic --feedback per lo stato di "set"
    );
end entity SistemaCronometro;


architecture rtl of SistemaCronometro is

    component cronometro is port(
        clk : in std_logic;
        enable: in std_logic;
        reset: in std_logic;
        
        set: in std_logic;

        input_hour: in std_logic_vector(4 downto 0);
        input_min: in std_logic_vector(5 downto 0);
        input_sec: in std_logic_vector(5 downto 0);

        hour: out std_logic_vector(4 downto 0);
        min: out std_logic_vector(5 downto 0);
        sec: out std_logic_vector(5 downto 0);
        fullCount : out std_logic
    );
    end component;



    component ControlUnit is port(
        clk: in std_logic;

        button_mode: in std_logic;
        button_reset : in std_logic;
        button_start_count: in std_logic;
        button_load_input: in std_logic; 


        start_count: out std_logic;
        offDisplay: out std_logic;

        setCron: out std_logic;
        selLoader: out std_logic_vector(1 downto 0)
    );
    end component;


    component display_seven_segments is port(
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
        ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
        DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare

        ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
        CATHODES : out  STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;

    component clock_filter is generic(
        CLKOUT_freq : integer := 10
    );
    port( --clock filter per diminuire la frequenza di conteggio del sistema
        clock_in : in  STD_LOGIC;
		reset : in STD_LOGIC;
        clock_out : out  STD_LOGIC
    );
    end component;

    component ButtonDebouncer is port(
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC
    );
    end component;


    component loader is port(
        input_switch : in std_logic_vector(5 downto 0);
        selection_input: in std_logic_vector(1 downto 0);
        
        
        output_switch: out std_logic_vector(16 downto 0)
    );
    end component;


    component mux_21 is port(
        zero, enable: in std_logic; 
		s: in std_logic;
		y: out std_logic
    );
    end component;



    signal enable_Cron : std_logic; 
    signal enable_Cron_mux: std_logic;

    signal cutoMux: std_logic;

    signal setCUtoCron: std_logic;

    signal resetDisplay: std_logic;

    signal hourCUDISPLAY: std_logic_vector(4 downto 0);
    signal minCUDISPLAY: std_logic_vector(5 downto 0);
    signal secCUDISPLAY: std_logic_vector(5 downto 0);


    signal orario_su_display: std_logic_vector(31 downto 0);

    signal buttons_cleared: std_logic_vector(2 downto 0);

    signal loaderToCron: std_logic_vector(16 downto 0);
    signal selLoader_sig: std_logic_vector(1 downto 0); 

    constant zero_const: std_logic :='0';

    
begin

    orario_su_display <= "00000000000" & hourCUDISPLAY & "00" & minCUDISPLAY & "00" & secCUDISPLAY;
    
    sec_to_Led<=secCUDISPLAY;

    setLed <= setCUtoCron;

    filter: clock_filter port map (
        clock_in => clk,
        reset=> reset,
        clock_out=> enable_Cron
    );



    CU: ControlUnit port map (
        clk=>clk,

        button_mode=> buttons_cleared(2),
        button_reset => reset,
        button_start_count=> buttons_cleared(1),

        button_load_input => buttons_cleared(0),

        start_count => cutoMux,

        offDisplay => resetDisplay,

        setCron=> setCUtoCron,
        selLoader=> selLoader_sig
    );


    muxEnable: mux_21 port map(
        zero=> zero_const,
        enable=> enable_Cron,

		s => cutoMux,
		y => enable_Cron_mux
    );


    loader_switch: loader port map (

        input_switch => input_loaded_sis,

        selection_input=> selLoader_sig, --impostare le selezioni dalla CU!

       
        output_switch=> loaderToCron 
    );


    cronos: cronometro port map(

        clk => clk,
        enable=> enable_Cron_mux,
        reset => reset,

        set=> setCUtoCron,

        input_hour=> loaderToCron(16 downto 12),
        input_min=>  loaderToCron(11 downto 6),
        input_sec=>  loaderToCron(5 downto 0),
        
        hour => hourCUDISPLAY,
        min => minCUDISPLAY,
        sec => secCUDISPLAY,

        fullCount => fullCount_uscita
    );



    display: display_seven_segments port map (

        CLK => clk,
        RST => resetDisplay,
        VALUE => orario_su_display,
        ENABLE => "00111111",-- decide quali cifre abilitare
        DOTS => "00010100", -- decide quali punti visualizzare

        ANODES => anodes_out,
        CATHODES => cathodes_out
    );

    deb_load_input: ButtonDebouncer port map (
        RST=> reset,
        CLK => clk,
        BTN => button_load_input_sis,
        CLEARED_BTN => buttons_cleared(0)
    );


    deb_start: ButtonDebouncer port map (
        RST=> reset,
        CLK => clk,
        BTN => button_start_count_sis,
        CLEARED_BTN => buttons_cleared(1)
    );

    deb_mode: ButtonDebouncer port map (
        RST=> reset,
        CLK => clk,
        BTN => button_mode_sis,
        CLEARED_BTN => buttons_cleared(2)
    );

    
end architecture rtl;



