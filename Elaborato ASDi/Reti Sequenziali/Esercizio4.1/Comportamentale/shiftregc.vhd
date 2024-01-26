library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity shiftregc is
    generic (
        n_bits : positive :=4
    );
    port (
        data_in : in std_logic_vector(n_bits-1 downto 0);
         --dati in ingresso 
        selection : in std_logic_vector(2 downto 0); --slezione dello shift, imposto 3 bit per permettere di avere 000 come "stato di quiete" del registro
        clk : in std_logic; --segnale per la sincronizzazione 
        reset : in std_logic; --segnale di reset


        data_out : out std_logic_vector(n_bits-1 downto 0) --dati in uscita
    );
end entity shiftregc;



architecture comportamentale of shiftregc is
    
begin
    
    proc_name: process(clk)
    begin
        if rising_edge(clk) then
        
            if reset = '1' then
                data_out<= (others => '0'); --questo ci permette di porre tutti i bit a 0 per il reset
            end if;
                        
            if (selection = "001")  then
                data_out <= data_in(n_bits-2 downto 0) & '0'; --shift a sinistra di 1
            elsif  (selection = "011") then
                data_out <= data_in(n_bits-3 downto 0) & "00"; --shift a sinistra di 2
            elsif selection = "010" then 
                data_out <= '0' & data_in(n_bits-1 downto 1); --shift a destra di 1
            elsif selection = "100" then 
                data_out <= "00" & data_in(n_bits-1 downto 2); --sghift a destra di 2
            else 
                data_out<= (others => '-');
            end if;
            
        end if;
    end process proc_name;
    
    
end architecture comportamentale;


