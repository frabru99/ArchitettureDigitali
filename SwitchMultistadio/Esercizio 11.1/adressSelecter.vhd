library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adressSelecter is
    port (

        s_selecter_source_porta_1 : in STD_LOGIC;
        s_selecter_des_porta_1 : in STD_LOGIC;

        s_selecter_source_porta_2 : in STD_LOGIC;
        s_selecter_des_porta_2: in STD_LOGIC;

        selection : in STD_LOGIC;

        s_source_out : out STD_LOGIC;
        s_des_out : out STD_LOGIC
        
    );
end entity adressSelecter;

architecture rtl of adressSelecter is
    
begin

    processSelecter : process(selection)
    
    begin
        if(selection = '0') then
            s_source_out <= s_selecter_source_porta_1 ;
            s_des_out <= s_selecter_des_porta_1;
        elsif(selection = '1') then
            s_source_out <= s_selecter_source_porta_2;
            s_des_out <= s_selecter_des_porta_2;
        end if;
    
    end process;
    
    
    
end architecture rtl;