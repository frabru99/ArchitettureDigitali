library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tbCron is
end entity tbCron;

architecture tb of tbCron is
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal set : std_logic := '0';
    signal input_loaded : std_logic_vector(16 downto 0) := (others => '0');
    signal hour : std_logic_vector(4 downto 0);
    signal min : std_logic_vector(5 downto 0);
    signal sec : std_logic_vector(5 downto 0);
    signal fullCount : std_logic;

    component cronometro is
        port (
            clk : in std_logic;
            reset: in std_logic;
            set: in std_logic;
            input_loaded: in std_logic_vector(16 downto 0);
            hour: out std_logic_vector(4 downto 0);
            min: out std_logic_vector(5 downto 0);
            sec: out std_logic_vector(5 downto 0);
            fullCount : out std_logic
        );
    end component cronometro;

begin
    dut: cronometro port map (
        clk => clk,
        reset => reset,
        set => set,
        input_loaded => input_loaded,
        hour => hour,
        min => min,
        sec => sec,
        fullCount => fullCount
    );

    clk_process :process
    begin
        clk <= '0';
        wait for 3 ns;
        clk <= '1';
        wait for 3 ns;
    end process;

    stim_proc: process
    begin
        -- Aggiungi qui la tua sequenza di stimoli
        wait for 30 ns;
        input_loaded <= "10111111010110000";
        set <= '1';
        wait for 3 ns;
        set <= '0';
        wait for 880 ns;
        reset<= '1';
        wait for 3 ns;
        reset <= '0';
        
        
        
        wait;
    end process;

end architecture tb;
