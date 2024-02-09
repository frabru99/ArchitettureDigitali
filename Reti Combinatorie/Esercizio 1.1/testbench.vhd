library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is

    component mux_16_1
        port (input_16_1   : in std_logic_vector (0 to 15);
              control_16_1 : in std_logic_vector (0 to 3);
              y_16_1       : out std_logic);
    end component;

    signal input_16_1   : std_logic_vector (0 to 15);
    signal control_16_1 : std_logic_vector (0 to 3);
    signal y_16_1       : std_logic;

begin

    dut : mux_16_1
    port map (input_16_1   => input_16_1,
              control_16_1 => control_16_1,
              y_16_1       => y_16_1);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        input_16_1 <= (others => '0');
        control_16_1 <= (others => '0');

        wait for 10 ns;
        input_16_1 <= "1000000000000000";
        wait for 100 ns;


        input_16_1 <= "0000000100000000";
        control_16_1 <= "1110";


        wait for 100 ns;
        
        
        input_16_1 <= "0000000000000001";
        control_16_1 <= "1111";


        wait for 100 ns;
        wait;
    end process;

end tb;

