library IEEE;
use IEEE.std_logic_1164.all;

entity tbmPOPC is
end entity tbmPOPC;

architecture tb_architecture of tbmPOPC is
    signal clk_tb, reset_tb, start_tb, selectionM_tb : std_logic := '0';


    component mPOPC
        port (
            clk: in std_logic;
            reset: in std_logic;
            start: in std_logic;
            selectionM: in std_logic
        );
    end component;

begin
    DUT : mPOPC
        port map (
            clk => clk_tb,
            reset => reset_tb,
            start => start_tb,
            selectionM => selectionM_tb
        );

    clock_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process clock_process;

    stimulus_process: process
    begin
        
        start_tb <= '1';
        selectionM_tb<='0';
        wait for 10 ns;
        start_tb <= '0';
        
        wait for 400 ns;
        start_tb <= '1';
        selectionM_tb<='0';
        wait for 10 ns;
        start_tb <= '0';
        
        

        
        wait;
    end process stimulus_process;

end architecture tb_architecture;
