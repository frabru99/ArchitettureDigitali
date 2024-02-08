library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity demux_1_2 is
    port (
        in_1_2 : in STD_LOGIC_VECTOR(1 downto 0);
        out_1_2_porta_1 : out STD_LOGIC_VECTOR(1 downto 0);
        out_1_2_porta_2 : out STD_LOGIC_VECTOR(1 downto 0);
        s_1_2 : in STD_LOGIC
    );
end entity demux_1_2;

architecture rtl of demux_1_2 is
    
begin
    
    out_1_2_porta_1 <= in_1_2 when s_1_2 = '0' else
                        "00"; 
    out_1_2_porta_2 <= in_1_2 when s_1_2 = '1'else
                        "00";
    
end architecture rtl;