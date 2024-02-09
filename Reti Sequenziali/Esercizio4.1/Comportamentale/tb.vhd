library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture behavior of tb is
    constant n_bits: positive := 4;
    signal data_in : std_logic_vector(n_bits-1 downto 0);
    signal selection : std_logic_vector(2 downto 0);
    signal clk_sig : std_logic;
    signal reset : std_logic := '0';
    signal data_out : std_logic_vector(n_bits-1 downto 0);

    component shiftregc is
        generic (
            n_bits : in integer := 4
        );
        port (
            data_in : in std_logic_vector(n_bits-1 downto 0);
            selection : in std_logic_vector(2 downto 0);
            clk : in std_logic;
            reset : in std_logic;
            data_out : out std_logic_vector(n_bits-1 downto 0)
        );
    end component;

begin
    dut: shiftregc
        generic map (n_bits => n_bits)
        port map (data_in => data_in, selection => selection, clk => clk_sig, reset => reset, data_out => data_out);

    clk_process : process
    begin
        while true loop
            clk_sig <= '0';
            wait for 10 ns;
            clk_sig <= '1';
            wait for 10 ns;
        end loop;
    end process;

    stim_proc: process
    begin
        -- Shift left by 1
        wait for 5 ns;
        selection <= "001";
        data_in <= "1001";
        wait for 20 ns;
        
        selection<="010";
        wait for 20 ns;

        -- Shift right by 1
        selection <= "010";
        data_in <= "1011";
        wait for 20 ns;

        -- Shift left by 2
        selection <= "011";
        data_in <= "1111";
        wait for 20 ns;
        
        selection<="000";
        wait for 10 ns; --qui lo shift register si ferma e pone solo data_mem in uscita

        -- Shift right by 2
        selection <= "100";
        data_in <= "1001";
        wait for 20 ns;
        selection<="000";

        -- End simulation
        wait;
    end process;
end behavior;
