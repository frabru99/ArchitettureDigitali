
library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is

    component Sistema
        port (input_16_4       : in std_logic_vector (0 to 7);
              output_16_4      : out std_logic_vector (0 to 3);
              control_16_1_sis : in std_logic_vector (0 to 3);
              control_1_4_sis  : in std_logic_vector (0 to 1));
    end component;

    signal input_16_4       : std_logic_vector (0 to 7);
    signal output_16_4      : std_logic_vector (0 to 3);
    signal control_16_1_sis : std_logic_vector (0 to 3);
    signal control_1_4_sis  : std_logic_vector (0 to 1);

begin

    dut : Sistema
    port map (input_16_4       => input_16_4,
              output_16_4      => output_16_4,
              control_16_1_sis => control_16_1_sis,
              control_1_4_sis  => control_1_4_sis);

    stimuli : process
    begin
        
        input_16_4 <= (others => '0');
        control_16_1_sis <= (others => '0');
        control_1_4_sis <= (others => '0');

        

        wait for 100 ns;


        input_16_4 <= "0000000010000000";
        control_16_1_sis <= "0001";
        control_1_4_sis <= "01";
        
        wait for 100 ns;
        
        input_16_4 <= "0000000000000010";
        control_16_1_sis <= "1111";
        control_1_4_sis <= "11";
        

        wait;
    end process;

end tb;

