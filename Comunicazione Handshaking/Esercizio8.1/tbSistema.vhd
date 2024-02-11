library IEEE;
use IEEE.std_logic_1164.all;

entity tbSistema is
end entity tbSistema;

architecture tb_arch of tbSistema is

    -- Constants for clock period and simulation duration
    constant CLOCK_PERIODA : time := 3 ns;
    constant CLOCK_PERIODB : time := 7.5 ns;
    

    -- Signals for testbench
    signal clkA_tb : std_logic := '0';
    signal clkB_tb: std_logic :='1';
    signal start_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
   

begin

    -- Instantiate the DUT (Design Under Test)
    dut : entity work.Sistema
        port map (
            clkA => clkA_tb,
            clkB => clkB_tb, 
            start => start_tb,
            reset => reset_tb
        );

    -- Clock process
    process_a: process
    begin
        while true loop
            clkA_tb <= '0';
            wait for CLOCK_PERIODA / 2;
            clkA_tb <= '1';
            wait for CLOCK_PERIODA / 2;
        end loop;
        wait;
    end process process_a;
    
    process_b: process
    begin
        while true loop
            clkB_tb <= '0';
            wait for CLOCK_PERIODB / 2;
            clkB_tb <= '1';
            wait for CLOCK_PERIODB / 2;
        end loop;
        wait;
    end process process_b;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize inputs
        start_tb <= '0';
        reset_tb <= '0';

        

        -- Start the system
        start_tb <= '1';
       

        -- End simulation
        wait;
    end process stimulus_process;

end architecture tb_arch;
