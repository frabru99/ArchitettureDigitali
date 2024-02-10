library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ControlUnit is
    port (
        clk: in std_logic;

        button_mode: in std_logic; --bottone per la modalità
        button_reset : in std_logic; --bottone per il reset
        button_start_count: in std_logic; --bottone per far cominciare il conteggio
        button_load_input: in std_logic;  --bottone per acquisire l'input
        button_interTime: in std_logic; --bottone per acquisire l'intertempo
       

        
        start_count: out std_logic; --diventa un segnale di selezione del multiplexer che permette di selezionare l'enable oppure uno 0. 
        offDisplay: out std_logic;

        setCron: out std_logic; --segnale di set per caricare gli ingressi dagli switch
        selLoader: out std_logic_vector(1 downto 0);


        --visualizzazione e scrittura nella memoria degli InterTempi
        write_on_Mem: out std_logic;
        read_on_Mem: out std_logic;
        nextCountAddress: out std_logic; --segnale di conteggio del contatore, che indica l'indirizzo di lettura/scrittura
        changeToVisualMode: out std_logic;
        reset_countAddress: out std_logic; --reset del conteggio quando passo in modalità di lettura
        setLastWrittenCount: out std_logic
    );
end entity ControlUnit;



architecture rtl of ControlUnit is


    TYPE stati is (idle, caricaSec, caricaMin, caricaHour, setLoadedInput, startCronometro, visualMode, interTimeSave);
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
                write_on_Mem<='1'; --perchè la memoria scrive o legge sul falling edge di questi due segnali
                read_on_Mem<='1';
                changeToVisualMode<='0';
                reset_countAddress<='0';
                setLastWrittenCount<='0';
            end if;


            write_on_Mem<='1';
            read_on_Mem<='1';
            reset_countAddress<='0';
            setLastWrittenCount<='0';
            nextCountAddress<='1';
            
            
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
                stato_corrente<= setLoadedInput;
                
                
            elsif(stato_corrente=setLoadedInput AND button_load_input='1') then 
                setCron<='1';
                stato_corrente<=idle;
                
            elsif (stato_corrente=startCronometro AND button_mode='1') then
                start_count<='0';
                stato_corrente<=idle;

            elsif (stato_corrente=idle AND button_start_count='1') then
                setCron<='0';
                stato_corrente<=startCronometro;
                start_count<='1';

            elsif(stato_corrente=startCronometro AND button_interTime='1') then --voglio salvare un intertempo
                write_on_Mem<='0'; --segnale di write alla MEM
                stato_corrente<=interTimeSave; --cambio stato
            
            elsif (stato_corrente=interTimeSave) then --stato in più per conteggio successivo
                nextCountAddress<='0'; --mando avanti l'address di scrittura
                stato_corrente<=startCronometro; --ritorno in start cronometro

            elsif(stato_corrente=idle AND button_interTime='1') then 
                stato_corrente<= visualMode; --stato di visualizzazione
                changeToVisualMode<='1'; --gestione display con un multiplexer, questa è la selezione

                --resettare conteggio per partire dalla posizione 0 della memoria
                reset_countAddress<='1'; --reset del contatore
                read_on_Mem<='0';


            elsif(stato_corrente=visualMode AND button_mode='1') then 
                stato_corrente<=idle;
                changeToVisualMode<='0';
                --gestire lastWritten, set del contatore dedicato
                setLastWrittenCount<='1'; 

            elsif(stato_corrente=visualMode AND button_interTime='1') then --voglio andare avanti negli intertempi
                nextCountAddress<='0';
                read_on_Mem<='0';
                
            end if;
            
        end if;
    end process;
    
    
    
end architecture rtl;