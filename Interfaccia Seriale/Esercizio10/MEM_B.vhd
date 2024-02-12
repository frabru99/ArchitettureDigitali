------MEMORIA MEM----------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEM_B is
    port (
        in_Mem : in STD_LOGIC_VECTOR(7 downto 0);
        write_Mem : in STD_LOGIC;
        adress_Mem : in STD_LOGIC_VECTOR(2 downto 0);
        outMem : out  STD_LOGIC_VECTOR(7 downto 0)
    );
end entity MEM_B;


architecture rtl of MEM_B is

    --Definizione della memoria come tipo
    type mem_type is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    shared variable mem_v : mem_type := (others => x"00");
    

begin

    processMem : process(write_Mem) is

    begin
        if (falling_edge(write_Mem)) then
            mem_v(to_integer(unsigned(adress_Mem))) := in_Mem;
            outMem <= mem_v(to_integer(unsigned(adress_Mem)));
        end if;

    end process;
    
end architecture rtl;