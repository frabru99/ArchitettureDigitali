library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity switchMultiStadio_tb is
end entity switchMultiStadio_tb;

architecture tb of switchMultiStadio_tb is

    -- Constants
    constant CLK_PERIOD : time := 10 ns; -- Clock period

    -- Signals
    signal clk_tb : std_logic := '0'; -- Testbench clock signal
    signal in_sw_porta_1_tb : std_logic_vector(1 downto 0) := "00"; -- Example input for in_sw_porta_1
    signal in_sw_porta_2_tb : std_logic_vector(1 downto 0) := "00"; -- Example input for in_sw_porta_2
    signal adr_sw_source_porta_1_tb : std_logic := '0'; -- Example input for adr_sw_source_porta_1
    signal adr_sw_des_porta_1_tb : std_logic := '0'; -- Example input for adr_sw_des_porta_1
    signal adr_sw_source_porta_2_tb : std_logic := '0'; -- Example input for adr_sw_source_porta_2
    signal adr_sw_des_porta_2_tb : std_logic := '0'; -- Example input for adr_sw_des_porta_2
    signal warning_sw_1_tb : std_logic := '0'; -- Example input for warning_sw_1
    signal warning_sw_2_tb : std_logic := '0'; -- Example input for warning_sw_2

    -- Component instantiation
    component switchMultiStadio
        port (
            clk : in std_logic;
            in_sw_porta_1 : in std_logic_vector(1 downto 0);
            in_sw_porta_2 : in std_logic_vector(1 downto 0);
            out_sw_porta_1 : out std_logic_vector(1 downto 0);
            out_sw_porta_2 : out std_logic_vector(1 downto 0);
            adr_sw_source_porta_1 : in std_logic;
            adr_sw_des_porta_1 : in std_logic;
            adr_sw_source_porta_2 : in std_logic;
            adr_sw_des_porta_2 : in std_logic;
            warning_sw_1 : in std_logic;
            warning_sw_2 : in std_logic
        );
    end component;

begin

    -- DUT instantiation
    dut: switchMultiStadio
        port map (
            clk => clk_tb,
            in_sw_porta_1 => in_sw_porta_1_tb,
            in_sw_porta_2 => in_sw_porta_2_tb,
            out_sw_porta_1 => open, -- Unused output
            out_sw_porta_2 => open, -- Unused output
            adr_sw_source_porta_1 => adr_sw_source_porta_1_tb,
            adr_sw_des_porta_1 => adr_sw_des_porta_1_tb,
            adr_sw_source_porta_2 => adr_sw_source_porta_2_tb,
            adr_sw_des_porta_2 => adr_sw_des_porta_2_tb,
            warning_sw_1 => warning_sw_1_tb,
            warning_sw_2 => warning_sw_2_tb
        );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop -- Simulate for 1000 ns
            clk_tb <= not clk_tb; -- Toggle the clock
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_process;

    -- Stimulus process
    stimulus: process
    begin
        -- Insert your test stimuli here
        -- Example:
        wait for 50ns;
        in_sw_porta_1_tb <= "01"; -- Example input for in_sw_porta_1
        wait for 20 ns;
        in_sw_porta_2_tb <= "10"; -- Example input for in_sw_porta_2
        wait for 20 ns;
        adr_sw_source_porta_1_tb <= '1'; -- Example input for adr_sw_source_porta_1
        wait for 20 ns;
        adr_sw_des_porta_1_tb <= '0'; -- Example input for adr_sw_des_porta_1
        wait for 20 ns;
        adr_sw_source_porta_2_tb <= '0'; -- Example input for adr_sw_source_porta_2
        wait for 20 ns;
        adr_sw_des_porta_2_tb <= '1'; -- Example input for adr_sw_des_porta_2
        wait for 20 ns;
        warning_sw_2_tb <= '1'; -- Example input for warning_sw_1
        wait for 20 ns;
        warning_sw_1_tb <= '1'; -- Example input for warning_sw_2
        
        

        -- Insert more stimuli or use loops for repetitive tests

        wait;
    end process stimulus;

end architecture tb;
