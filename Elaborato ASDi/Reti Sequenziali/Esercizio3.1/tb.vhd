library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is
end entity tb;

architecture tb_architecture of tb is
    signal y_tb, i_tb, clk_tb, reset_tb, m_tb : std_logic := '0';
begin
    uut: entity work.riconoscitoristotsparz
        port map (
            y => y_tb,
            i => i_tb,
            clk => clk_tb,
            reset => reset_tb,
            m => m_tb
        );

    
    process
    begin
        clk_tb <= '0';
        wait for 5 ns;
        clk_tb <= '1';
        wait for 5 ns;
    end process;

    
    process
    begin
        
        

        wait for 10 ns;
        reset_tb <= '0';
        m_tb <= '1';

        wait for 10 ns;
        
        i_tb <= '1';
        wait for 15 ns;
        i_tb <= '0';
        wait for 15 ns;
        i_tb <= '1';
        
        
        wait for 50 ns;
        m_tb <= '0';    
        wait for 10 ns;

        i_tb <= '1';
        wait for 10 ns;
        i_tb <= '0';
        wait for 10 ns;
        i_tb <= '1';
        
        
        

        wait for 1000 ns; -- Simulate for a while
        report "Simulation finished" severity note;
        wait;
    end process;
end architecture tb_architecture;
