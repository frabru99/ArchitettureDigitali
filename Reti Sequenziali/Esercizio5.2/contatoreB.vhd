library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity contatoreB is
    generic(    
        k: integer:=4;
        max_count: integer:=16

    );
    port (

        clk: in std_logic;
        reset: in std_logic;
        set: in std_logic;
        input_to_load: in std_logic_vector(k downto 0);
        enable: in std_logic;

        counter_out: out std_logic_vector(k downto 0);
        divider: out std_logic:='0'
        
    );
end entity contatoreB;



architecture rtl of contatoreB is
    
    signal c: std_logic_vector(k downto 0) := (others=> '0');

begin

    counter_out <= c;

    process (clk)
    begin


            if(reset ='1') then 
                c<=(others => '0');
                divider<='1';
            elsif set='1' then 
                c<=input_to_load;
                divider<='1';
                
            elsif falling_edge(enable) then
                if(to_integer(unsigned(c))>=max_count) then 
                    c<= (others => '0');
                    divider<='0';
                else
                    divider<='1';
                    c<= std_logic_vector(unsigned(c)+1);
                end if;
                
            end if;
        
    end process;
    
    
    
end architecture rtl;