------MEMORIA MEM----------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--Memoria del sistema B

entity MEM is
    port (
        in_Mem : in STD_LOGIC_VECTOR(8 downto 0); --è da 9 per considerare un bit di overflow 
        write_Mem : in STD_LOGIC;
        read_Mem: in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(4 downto 0);
        
        dataread_out: out STD_LOGIC_VECTOR(8 downto 0)
        
    );
end entity MEM;


architecture rtl of MEM is

    --Definizione della memoria come tipo
    type mem_type is array (0 to 31) of STD_LOGIC_VECTOR(8 downto 0);
    shared variable mem_v : mem_type;

    --inizializzo le prime 16 posizioni della memoria per contenere le stringhe Y
     constant rilocation: std_logic_vector:="10000";

     constant zero: std_logic_vector:="00000";
     constant uno: std_logic_vector:="00001";
     constant due: std_logic_vector:="00010";
     constant tre: std_logic_vector:="00011";
     constant quattro: std_logic_vector:="00100";
     constant cinque: std_logic_vector:="00101";
     constant sei: std_logic_vector:="00110";
     constant sette: std_logic_vector:="00111";
     constant otto: std_logic_vector:="01000";
     constant nove: std_logic_vector:="01001";
     constant dieci: std_logic_vector:="01010";
     constant undici: std_logic_vector:="01011";
     constant dodici: std_logic_vector:="01100";
     constant tredici: std_logic_vector:="01101";
     constant quattordici: std_logic_vector:="01110";
     constant quindici: std_logic_vector:="01111";
    
     shared variable addressRelocated: std_logic_vector(4 downto 0):="00000";
     
begin
    
    
    

    processWrite : process(write_Mem) is
    
  
    begin
    
    
    mem_v(to_integer(unsigned(zero))):="0"& x"10";
    mem_v(to_integer(unsigned(uno))):="0" & x"11"; --concateno il bit in più
    mem_v(to_integer(unsigned(due))):="0" & x"13";
    mem_v(to_integer(unsigned(tre))):="0" & x"a0";
    mem_v(to_integer(unsigned(quattro))):="0" & x"14";
    mem_v(to_integer(unsigned(cinque))):="0" & x"1b";
    mem_v(to_integer(unsigned(sei))):="0" & x"1c";
    mem_v(to_integer(unsigned(sette))):="0" & x"10";
    mem_v(to_integer(unsigned(otto))):="0" & x"1d";
    mem_v(to_integer(unsigned(nove))):="0" & x"1f";
    mem_v(to_integer(unsigned(dieci))):="0" & x"11";
    mem_v(to_integer(unsigned(undici))):="0" & x"89";
    mem_v(to_integer(unsigned(dodici))):="0" & x"43";
    mem_v(to_integer(unsigned(tredici))):="0" & x"21";
    mem_v(to_integer(unsigned(quattordici))):="0" & x"16";
    mem_v(to_integer(unsigned(quindici))):="0" & x"f1"; --devo sommare 16 come spiazzamento di base
    
    
    addressRelocated:=std_logic_vector(unsigned(adress_Mem)+unsigned(rilocation));
        
   
        if (falling_edge(write_Mem)) then --scrittura
            mem_v(to_integer(unsigned(addressRelocated))) := in_Mem; --devo scrivere quello che esce dalla somma
        end if;

    end process;

    

    processRead: process(read_Mem) 

    begin

        if(falling_edge(read_Mem)) then 
            dataread_out<= mem_v(to_integer(unsigned(adress_Mem)));
        end if;

    end process;
    
     
    

end architecture rtl;