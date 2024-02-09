library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controlUnit is
    port (
    
        clk : in STD_LOGIC;

        --Segnali di prenotazione invio pacchetto da parte delle destinazioni
        warning_1 : in STD_LOGIC;
        warning_2 : in STD_LOGIC;

        --Comando di uscita della control unit che comandano lo switch
        command_to_selecter : out STD_LOGIC

    );
end entity controlUnit;

architecture rtl of controlUnit is
    
begin
    
    processChoice : process (clk) is 

    begin
           if(rising_edge(clk)) then
            --Se arrivano due warning in contemporanea, prediligo la SECONDA porta di ingresso
            if(warning_1='1' and warning_2 = '1') then 
                command_to_selecter <= '1';
            
            --Altrimenti verifico chi mi ha inviato il pacchetto e prendo le sue selezioni
            elsif(warning_1 = '1'and warning_2 = '0') then
                command_to_selecter <= '0';
            elsif(warning_2 = '1'and warning_1 = '0') then
                command_to_selecter <= '1';
            end if;
           end if;

    end process;
    
    
end architecture rtl;