library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controlUnit is
    port (
        clk : in std_logic;
        reset : in std_logic; --segnale di reset 
        count : in std_logic_vector (3 downto 0); --conteggio del contatore
        read_ext: in std_logic;
        
        
        reset_count : out std_logic;
        read : out std_logic; --segnale di read 
        write: out std_logic; --segnale di write
        write_count: out std_logic := '1' --segnale di aumento del conteggio  
    );
end entity controlUnit;



architecture rtl of controlUnit is

    TYPE stati IS (idle, readORwrite, terminated);


    signal stato_corrente : stati:=idle;
    
    shared variable read_var : std_logic:='0';
    shared variable write_var: std_logic:='0'; 

    
begin

    p: process (clk, reset)
    begin
        if reset = '1' then
            stato_corrente <= idle;
            reset_count <= '1';
            write<= '0';
            read<='0';
            read_var:='0';
            write_var:='0';

        elsif rising_edge(clk) then
        
            reset_count <= '0';
           

            if stato_corrente = idle AND read_ext = '1' then 
                read_var:='1';
                read <= '1';
               

                stato_corrente<=readORWrite;

            elsif stato_corrente=readORwrite AND read_var='1' AND write_var ='0' then 
                read_var:='0';
                read <= '0';
                write <= '1';
                write_var:='1';
                
                write_count<='1'; --serve per un ipotetico "reset" di write_count

               
                
            elsif stato_corrente=readORWrite AND write_var='1' AND read_var='0' then 
            
                write_var:='0';
                write <='0';
                write_count <='0';
                
               stato_corrente<= idle;

                
            elsif stato_corrente=terminated then 
            
                stato_corrente<= idle;
                write_var:='0';
                write <='0';
                write_count <='1';
                
                read <='0';
                read_var:='0';
                reset_count<='1';
                
                
            end if;
            
            if stato_corrente=readORWrite AND count="1111" then
             
                stato_corrente<=terminated;
               
            end if;
            
            


            
        end if;
    end process;
    
    
    
end architecture rtl;