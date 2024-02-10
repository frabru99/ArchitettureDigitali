library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ControlUnit is
    port (
        clk: in std_logic;

        button_mode: in std_logic;
        button_reset : in std_logic;
        button_start_count: in std_logic;
        button_load_input: in std_logic; 


        start_count: out std_logic; --diventa un segnale di selezione del multiplexer che permette di selezionare l'enable oppure uno 0. 
        offDisplay: out std_logic;

        setCron: out std_logic; --segnale di set per caricare gli ingressi dagli switch
        selLoader: out std_logic_vector(1 downto 0)
        
        

    );
end entity ControlUnit;



architecture rtl of ControlUnit is


    TYPE stati is (idle, caricaSec, caricaMin, caricaHour, setLoadedInput, startCronometro);
    signal stato_corrente: stati := idle;

    

   
begin

    process (clk)
    begin
        if rising_edge(clk) then

            if(button_reset='1') then 
                stato_corrente<=idle;
                start_count<='0'; --mux settato a 0, non vado avanti nel conteggio
                --selLoader<="00"; --input dei contatori tutti a 0
                setCron<='0';
                offDisplay<='0';
            end if;
            
            
            
            if(stato_corrente=idle AND button_mode='1') then
                stato_corrente <= caricaSec;
                selLoader<="11"; --carico i secondi
                
            elsif(stato_corrente=caricaSec AND button_load_input='1') then 
                stato_corrente<=caricaMin;
                selLoader<="10";
               
            elsif(stato_corrente=caricaMin AND button_load_input='1') then 
                stato_corrente<=caricaHour;
                selLoader<="01";

            elsif (stato_corrente=caricaHour AND button_load_input='1')  then
                
                setCron<='1';
                stato_corrente<= setLoadedInput;
                
                
            elsif(stato_corrente=setLoadedInput AND button_load_input='1') then 
                setCron<='0';
                stato_corrente<=idle;
                
            elsif (stato_corrente=startCronometro AND button_mode='1') then
                start_count<='0';
                stato_corrente<=idle;
                setCron<='0';
                
            elsif (stato_corrente=idle AND button_start_count='1') then
                setCron<='0';
                stato_corrente<=startCronometro;
                start_count<='1';

            end if;
                        

        end if;
    end process;
    
    
    
end architecture rtl;