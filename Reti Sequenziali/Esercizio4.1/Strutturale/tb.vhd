library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is
end entity tb;

architecture testbench of tb is
    -- Constants
    constant n_bits : positive := 4;

    signal data_in_sig : std_logic_vector(n_bits-1 downto 0);
    signal selection_sig: std_logic_vector(1 downto 0);
    signal clk_sig, reset_sig, external_zero_sig, enable_input_sig, enable_output_sig : std_logic;
    signal data_out_sig : std_logic_vector(n_bits-1 downto 0);

    -- Instantiate the shiftregs component
    component shiftregs
        generic (
            n_bits : positive := 4
        );
        port (
            data_in : in std_logic_vector(n_bits-1 downto 0);
            selection : in std_logic_vector(1 downto 0);
            clk : in std_logic;
            reset : in std_logic;
            external_zero : in std_logic;
            enable_input : in std_logic;
            enable_output : in std_logic;
            data_out : out std_logic_vector(n_bits-1 downto 0)
        );
    end component;

begin

   
    

    -- Instantiate the shiftregs component
    UUT: shiftregs
        generic map (
            n_bits => n_bits
        )
        port map (
            data_in => data_in_sig,
            selection => selection_sig,
            clk => clk_sig,
            reset => reset_sig,
            external_zero => external_zero_sig,
            enable_input => enable_input_sig,
            enable_output => enable_output_sig,
            data_out => data_out_sig
        );


    clk_process :process
    begin
    while true loop 
        clk_sig <= '0';
        wait for 5 ns;
        clk_sig <= '1';
        wait for 5 ns;
    end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize inputs
        
        
        reset_sig <= '0';
        external_zero_sig <= '0';
        enable_input_sig <= '0';
        enable_output_sig <= '0';

        wait for 10 ns;

        -- Primo input
        data_in_sig <= "1111"; -- Example input data
        enable_input_sig <= '1';
        wait for 30 ns;

        enable_input_sig <= '0';

        selection_sig<= "00";
        wait for 10 ns;
        enable_output_sig <= '1';
        
        selection_sig<="01";
        wait for 10 ns;
        
         --secondo input
        enable_output_sig<='0';
        data_in_sig<="0110";
        enable_input_sig<='1';
        
        wait for 10 ns;
        
        enable_input_sig<='0';
        
        selection_sig <= "10";
        wait for 10 ns;
        enable_output_sig <='1';
        
        selection_sig<="11";
        wait for 10 ns;
        enable_output_sig<='0';
        
        
        

    
        -- Add more test scenarios as needed

        wait;
    end process stimulus_process;

end architecture testbench;
