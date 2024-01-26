library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture behavior of tb is
    signal data_in : std_logic_vector(4-1 downto 0);
    signal selection : std_logic_vector(2 downto 0);
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal data_out : std_logic_vector(4-1 downto 0);

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
        generic map (n_bits => 4)
        port map (data_in => data_in, selection => selection, clk => clk, reset => reset, data_out => data_out);

    clk_process :process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stim_proc: process
    begin
        -- Shift left by 1
        selection <= "001";
        data_in <= "1001";
        wait for 20 ns;

        -- Shift right by 1
        selection <= "010";
        data_in <= "1001";
        wait for 20 ns;

        -- Shift left by 2
        selection <= "011";
        data_in <= "1001";
        wait for 20 ns;

        -- Shift right by 2
        selection <= "100";
        data_in <= "1001";
        wait for 20 ns;

        -- End simulation
        wait;
    end process;
end behavior;
