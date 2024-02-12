library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CU_A is
    port (
        clk: in std_logic;
        start : in std_logic;
        Write_UART: out std_logic;
        conteggio_attuale: in std_logic_vector(2 downto 0); --mi permette di controllare il valore cui è arrivato il contatore
        conteggio: out std_logic; --conteggio contatore ROM
        TBE_UART: in std_logic
    );
end entity CU_A;

architecture rtl of CU_A is
    
    type stati is (IDLE, INVIA, TRASMETTI, FINE_TRASMISSIONE);
    signal stato_corrente, stato_prossimo : stati := IDLE;

begin

    
    
    CU_A: process(clk)
    begin
    
        if(rising_edge(clk)) then 
            stato_corrente<=stato_prossimo;
        end if; 
    end process;
    
    
    
    CU_A2: process(start, TBE_UART, stato_corrente) 
        begin
        
        Write_UART <= '0';
        conteggio <= '0';

        case stato_corrente is
            when IDLE =>
                Write_UART <= '0';
                
                if(start = '1') then
                    stato_prossimo<=INVIA;
                else 
                    stato_prossimo<=IDLE;
                end if;

            when INVIA => 
                Write_UART<='1';
                stato_prossimo<=TRASMETTI;
                
            when TRASMETTI =>
                Write_UART<='0';
                
                if(TBE_UART='1') then
                    stato_prossimo<=FINE_TRASMISSIONE;
                else
                    stato_prossimo<=TRASMETTI;
                end if;

            when FINE_TRASMISSIONE =>
                if(conteggio_attuale="111") then
                    stato_prossimo<=IDLE;

                else
                    conteggio<='1';
                    stato_prossimo<=INVIA;
                end if;
        end case;

        
        
        
        
        end process;
    
end architecture rtl;