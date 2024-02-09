library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity switchMultiStadio is
    port (
    
        clk : in STD_LOGIC;

        --Ingressi e uscite del "pacchetto" dallo switch
        in_sw_porta_1 : in STD_LOGIC_VECTOR(1 downto 0);
        in_sw_porta_2 : in STD_LOGIC_VECTOR(1 downto 0);
        out_sw_porta_1 : out STD_LOGIC_VECTOR(1 downto 0);
        out_sw_porta_2 : out STD_LOGIC_VECTOR(1 downto 0);

        --Indirizzi di sorgente e di arrivo delle porte
        adr_sw_source_porta_1 : in STD_LOGIC;
        adr_sw_des_porta_1 : in STD_LOGIC;
        adr_sw_source_porta_2 : in STD_LOGIC;
        adr_sw_des_porta_2 : in STD_LOGIC;

        --Segnali di advise dati dalle porte in connessione
        warning_sw_1 : in STD_LOGIC;
        warning_sw_2 : in STD_LOGIC

    );
end entity switchMultiStadio;

architecture rtl of switchMultiStadio is

    component parteOperativa is
        port(
            in_porta_1 : in STD_LOGIC_VECTOR(1 downto 0);
            in_porta_2 : in STD_LOGIC_VECTOR(1 downto 0);

            out_porta_1 : out STD_LOGIC_VECTOR(1 downto 0);
            out_porta_2 : out STD_LOGIC_VECTOR(1 downto 0);

            --La selezione la decide la control unit 
            s_source : in STD_LOGIC;
            s_des : in STD_LOGIC
        );
    end component;

    component adressSelecter is
        port(

            s_selecter_source_porta_1 : in STD_LOGIC;
            s_selecter_des_porta_1 : in STD_LOGIC;

            s_selecter_source_porta_2 : in STD_LOGIC;
            s_selecter_des_porta_2: in STD_LOGIC;

            selection : in STD_LOGIC;

            s_source_out : out STD_LOGIC;
            s_des_out : out STD_LOGIC
        );
        end component;

    component ControlUnit is
        port(
        
            clk : in STD_LOGIC;
        
            --Segnali di prenotazione invio pacchetto da parte delle destinazioni
            warning_1 : in STD_LOGIC;
            warning_2 : in STD_LOGIC;

            --Comando di uscita della control unit che comandano lo switch
            command_to_selecter : out STD_LOGIC
        );
    end component;

    ------Segnali di interconnessione-----------------
    signal CUToSelecter : STD_LOGIC;
    signal SelecterToMux : STD_LOGIC;
    signal SelecterToDemux : STD_LOGIC;
    
    
begin
    
    PO : parteOperativa
        port map(

            in_porta_1 => in_sw_porta_1,
            in_porta_2 => in_sw_porta_2,

            out_porta_1 => out_sw_porta_1,
            out_porta_2 => out_sw_porta_2,

            --La selezione la decide la control unit, ma caricata da Selecter intermedio
            s_source => SelecterToMux,
            s_des => SelecterToDemux
        );

    CU : controlUnit 
            port map(
            
                clk => clk,
            
                --Segnali di prenotazione invio pacchetto da parte delle destinazioni
                warning_1 => warning_sw_1,
                warning_2 => warning_sw_2,

                command_to_selecter => CUToSelecter
            );

    SEL : adressSelecter
            port map(
                s_selecter_source_porta_1 => adr_sw_source_porta_1,
                s_selecter_des_porta_1 => adr_sw_des_porta_1,

                s_selecter_source_porta_2 => adr_sw_source_porta_2,
                s_selecter_des_porta_2 => adr_sw_des_porta_2,

                selection => CUToSelecter,

                s_source_out => SelecterToMux,
                s_des_out => SelecterToDemux
            );
    
end architecture rtl;