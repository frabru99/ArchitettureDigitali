------MEMORIA MEM----------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--Memoria del sistema B

entity MEM is
    port (
        in_Mem : in STD_LOGIC_VECTOR(16 downto 0); 
        write_Mem : in STD_LOGIC;
        read_Mem: in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(2 downto 0);
        
        dataread_out: out STD_LOGIC_VECTOR(16 downto 0);
        lastWritten: out STD_LOGIC_VECTOR(2 downto 0)
    );
end entity MEM;


architecture rtl of MEM is

    --Definizione della memoria come tipo
    type mem_type is array (0 to 7) of STD_LOGIC_VECTOR(16 downto 0);
    shared variable mem_v : mem_type;

     
begin


   

    processWrite : process(write_Mem) is
    
    begin
    
        if (falling_edge(write_Mem)) then --scrittura
            mem_v(to_integer(unsigned(adress_Mem))) := in_Mem; --devo scrivere quello che esce dalla somma
            lastWritten<=std_logic_vector(unsigned(adress_Mem)+1);
        end if;

    end process;

    processRead: process(read_Mem) 

    begin

        if(falling_edge(read_Mem)) then 
            dataread_out<= mem_v(to_integer(unsigned(adress_Mem)));
            
        end if;

    end process;
    
     
    

end architecture rtl;