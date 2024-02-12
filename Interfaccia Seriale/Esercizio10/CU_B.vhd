library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CU_B is
    port (
        clk: in std_logic;
        conteggio_attuale: in std_logic_vector(2 downto 0);
        conteggio: out std_logic;
        read_UART: out std_logic;
        RDA_UART: in std_logic;
        Write_on_Mem: out std_logic;
        reset_Uart: out std_logic
    );
end entity CU_B;

architecture rtl of CU_B is
    
    type stati is (RICEVI, LEGGI, SCRIVI);
    signal stato_corrente, stato_prossimo: stati := RICEVI;


begin
    
    CU_B: process(clk)
    begin
        if(rising_edge(clk)) then 
            stato_corrente<=stato_prossimo;    
        end if;
        
    end process;
    
    
    CU_B2: process(RDA_UART, stato_corrente)
        begin
        
        Write_on_Mem <='1';
        read_UART <= '0';
        conteggio <='0';
        reset_Uart<='0';
    
    case stato_corrente is

        when RICEVI =>
             Write_on_Mem <='1';
             read_UART <= '0';
             conteggio <='0';
             reset_Uart<='0';
             
            if(RDA_UART = '1') then
                stato_prossimo<=LEGGI;
            else 
                stato_prossimo <= RICEVI; 
            end if;

        when LEGGI =>
            read_UART<='1';
            reset_Uart<='0';
            stato_prossimo <= SCRIVI;
            
             
        when SCRIVI =>  

            read_UART<='1';
            Write_on_Mem <= '0';
            reset_Uart<='1';
            
            if(conteggio_attuale="111") then
                stato_prossimo <= RICEVI;
            else
            
                conteggio <= '1';
                stato_prossimo <= RICEVI;

            end if;
        end case;
    
    
    
    end process;
    
    
end architecture rtl;
