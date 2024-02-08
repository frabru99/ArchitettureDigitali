-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tbSistema is
end;

architecture bench of tbSistema is

  component SistemaCronometro
      port (
          clk : in std_logic;
          input_loaded_sis: in std_logic_vector(5 downto 0);
          button_load_input_sis: in std_logic;
          button_start_count_sis: in std_logic;
          button_mode_sis: in std_logic;
          reset: in std_logic;
          anodes_out: out std_logic_vector(7 downto 0);
          cathodes_out : out std_logic_vector(7 downto 0);
          fullCount_uscita: out std_logic;
          sec_to_Led: out std_logic_vector(5 downto 0);
          setLed: out std_logic
      );
  end component;

  signal clk: std_logic;
  signal input_loaded_sis: std_logic_vector(5 downto 0);
  signal button_load_input_sis: std_logic;
  signal button_start_count_sis: std_logic;
  signal button_mode_sis: std_logic;
  signal reset: std_logic;
  signal anodes_out: std_logic_vector(7 downto 0);
  signal cathodes_out: std_logic_vector(7 downto 0);
  signal fullCount_uscita: std_logic;
  signal sec_to_Led: std_logic_vector(5 downto 0);
  signal setLed: std_logic ;

begin

  uut: SistemaCronometro port map ( clk                    => clk,
                                    input_loaded_sis       => input_loaded_sis,
                                    button_load_input_sis  => button_load_input_sis,
                                    button_start_count_sis => button_start_count_sis,
                                    button_mode_sis        => button_mode_sis,
                                    reset                  => reset,
                                    anodes_out             => anodes_out,
                                    cathodes_out           => cathodes_out,
                                    fullCount_uscita       => fullCount_uscita,
                                    sec_to_Led             => sec_to_Led,
                                    setLed                 => setLed );



    clock: process
    begin
        wait for 5 ns;
        clk<='1';
        wait for 5 ns;
        clk<='0';

    end process;

  stimulus: process
  begin
  
    wait for 20 ns;
    button_start_count_sis<='1';
    
    wait for 20 ns;
    button_start_count_sis<='0';


    wait;
  end process;


end;