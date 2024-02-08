library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2_1 is
    port (
        in_2_1_porta_1 : in STD_LOGIC_VECTOR(1 downto 0);
        in_2_1_porta_2 : in STD_LOGIC_VECTOR(1 downto 0);
        out_2_1 : out STD_LOGIC_VECTOR(1 downto 0);
        s_2_1 : in STD_LOGIC
    );
end entity mux_2_1;

architecture rtl of mux_2_1 is
    
begin
    
    out_2_1 <= in_2_1_porta_1 when s_2_1 = '0' else
                in_2_1_porta_2 when s_2_1 = '1' else
                "--";
    
    
end architecture rtl;