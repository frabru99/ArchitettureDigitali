------MEMORIA MEM----------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEM is
    port (
        in_Mem : in STD_LOGIC_VECTOR(3 downto 0);
        write_Mem : in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(3 downto 0);
        
        outMem : out  STD_LOGIC_VECTOR(3 downto 0)
        
    );
end entity MEM;


architecture rtl of MEM is

    --Definizione della memoria come tipo
    type mem_type is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    shared variable mem_v : mem_type := (others => x"0");
    

begin

    processMem : process(write_Mem) is

    begin
        if (falling_edge(write_Mem)) then
            mem_v(to_integer(unsigned(adress_Mem))) := in_Mem;
            outMem <= mem_v(to_integer(unsigned(adress_Mem)));
        end if;

    end process;
    
     
    

end architecture rtl;