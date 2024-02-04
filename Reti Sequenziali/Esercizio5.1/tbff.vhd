library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tbff is
end entity tbff;

architecture tb of tbff is
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal reset_from_count : std_logic := '0';
    signal set: std_logic := '0';
    signal input_loaded: std_logic := '0';
    signal Y : std_logic;

    constant clk_period : time := 5 ns;

begin
    uut: entity work.fft
        port map (
            clk => clk,
            reset => reset,
            reset_from_count => reset_from_count,
            set => set,
            input_loaded => input_loaded,
            Y => Y
        );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
    
        set<= '1';
        input_loaded<='0';
        wait for 15 ns;
        set <= '0';
        
        wait for 10 ns;
        reset_from_count <= '1';
        wait for 3 ns;
        
        
        
        
        wait;
    end process;

end architecture tb;
