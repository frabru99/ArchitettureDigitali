
library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is

    component Sistema
        port (controller_mem_sis : in std_logic_vector (0 to 3);
              controller_M_sis   : in std_logic;
              output_sis         : out std_logic_vector (0 to 3));
    end component;

    signal controller_mem_sis : std_logic_vector (0 to 3);
    signal controller_M_sis   : std_logic;
    signal output_sis         : std_logic_vector (0 to 3);

begin

    dut : Sistema
    port map (controller_mem_sis => controller_mem_sis,
              controller_M_sis   => controller_M_sis,
              output_sis         => output_sis);

    stimuli : process
    begin
        
        controller_mem_sis <= (others => '0');
        controller_M_sis <= '0';


        wait for 100 ns;

        controller_M_sis <= '1';
        controller_mem_sis <= "1000";

        wait for 100 ns;
        
        controller_M_sis <= '1';
        controller_mem_sis <= "1100";

         wait for 100 ns;
         
        controller_M_sis <= '0';
        

         wait for 100 ns;
        wait;
    end process;

end tb;

