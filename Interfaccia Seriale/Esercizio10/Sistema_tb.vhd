-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Sistema_tb is
end;

architecture bench of Sistema_tb is

  component Sistema
      port (
          clk: in std_logic;
          start_sis: in std_logic;
          reset_sis : in std_logic;
          dato_uscita: out std_logic_vector(7 downto 0)
      );
  end component;

  signal clk: std_logic;
  signal start: std_logic;
  signal reset: std_logic;
  signal dato_uscita: std_logic_vector(7 downto 0) ;

begin

  uut: Sistema port map ( clk         => clk,
                          start_sis       => start,
                          reset_sis       => reset,
                          dato_uscita => dato_uscita );

  stimulus: process
  begin
  
    -- Put initialisation code here

    start <= '1';
    wait for 10 ns;
    
    start<='0';
    


    -- Put test bench stimulus code here

    wait;
  end process;

  clock: process
  begin
  
    while true loop
        wait for 0.6 ps;
        clk <='0';
        wait for 0.6 ps;
        clk <='1';
    end loop;
  end process;

end;