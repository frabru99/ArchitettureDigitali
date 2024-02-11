library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sistema is
    port (
        clkA: in std_logic;
        clkB: in std_logic;
        start: in std_logic;
        reset: in std_logic
    );
end entity Sistema;


architecture rtl of Sistema is


    component SistemaA port(
        clk_sis: in std_logic;
        start_sis: in std_logic;
        
        okToSend_sis: in std_logic;
        ackfromB_sis: in std_logic;
        

        reset: in std_logic; 

        reqToSend_sis: out std_logic;
        data_out_sis: out std_logic_vector(8 downto 0);
        load_Operand_sis: out std_logic
        
    );
    end component;


    component SistemaB port(
        clk: in std_logic;

        reqfromA_sis: in std_logic;
        data_in_fromA_sis: in std_logic_vector(8 downto 0);
        loadOperand_fromA_sis: in std_logic;
        
        reset: in std_logic;

        okToSend_sis: out std_logic;
        acktoA_sis: out std_logic
    );
    end component;


    signal reqToSend: std_logic;
    signal okToSend: std_logic;
    signal ack: std_logic;
    signal load: std_logic;
    signal data: std_logic_vector(8 downto 0);
    
begin


    sisA: SistemaA port map(
        clk_sis=> clkA,
        start_sis=> start,

        okToSend_sis=> okToSend,
        ackfromB_sis=> ack,

        reset=> reset, 

        reqToSend_sis=> reqToSend, 
        data_out_sis=> data,
        load_Operand_sis=> load

    );


    sisB: SistemaB port map(
        clk=> clkB,

        reqfromA_sis=> reqToSend, 
        data_in_fromA_sis=> data, 
        loadOperand_fromA_sis=> load,

        reset=> reset, 

        okToSend_sis=> okToSend, 
        acktoA_sis=> ack

    );

    
    
    
end architecture rtl;