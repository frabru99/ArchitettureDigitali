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


shared variable data_mem : std_logic_vector(n_bits-1 downto 0);
    
begin
    
    
    proc_name: process(clk)
    begin
        if rising_edge(clk) then
        
            if reset = '1' then
                data_out <= (others => '0'); --questo ci permette di porre tutti i bit a 0 se il reset è alto 
                data_mem :=(others => '0');
            end if;
                        
            if (selection = "001")  then
                data_mem := data_mem(n_bits-2 downto 0) & '0';
                data_out <= data_mem; --shift a sinistra di 1
                
            elsif  (selection = "011") then
                data_mem := data_mem(n_bits-3 downto 0) & "00";
                data_out <= data_mem; --shift a sinistra di 2
                
            elsif selection = "010" then 
                data_mem := '0' & data_mem(n_bits-1 downto 1);
                data_out <= data_mem; --shift a destra di 1
                
            elsif selection = "100" then 
                data_mem := "00" & data_mem(n_bits-1 downto 2);
                data_out <= data_mem; --shift a destra di 2   
                    
            else 
                data_out<= data_mem;
            end if;
            
        end if;
    end process proc_name;
    
    proc_data_in: process(data_in)
        begin
            
                data_mem:=data_in;
           
        end process;
    
    
end architecture comportamentale;


