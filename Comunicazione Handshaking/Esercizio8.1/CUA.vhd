library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity CUA is
    port (
        clk: in std_logic;
        start: in std_logic;
        okToSend: in std_logic;
        ackfromB: in std_logic;
        data_in: in std_logic_vector(8 downto 0);
        reset: in std_logic;

        
        reqToSend: out std_logic;
        data_out: out std_logic_vector(8 downto 0):="UUUUUUUUU"; 
        load_OperandtoB: out std_logic;

        --conteggio e lettura
        readfromCutoRom: out std_logic;
        countA: out std_logic --segnale di conteggio
        
    );
end entity CUA;


architecture rtl of CUA is

    TYPE stati is (startCommunication, reqSended, okReceived, sendedData, loadOperands, ackReceived, elaborated);
    signal stato_corrente: stati:=startCommunication;
    
begin


    process (clk)
    begin

        if(reset='1') then
            stato_corrente<=startCommunication;
            reqToSend<='0';
            readfromCutoRom<='1';
            countA<='1';
            data_out<= (others => '0');

        end if;

        countA<='1';
        readfromCutoRom<='1';

        if(rising_edge(clk)) then 

            if(stato_corrente=startCommunication AND start='1') then
                stato_corrente<=reqSended;
                reqToSend<='1';
                readfromCutoRom<='0'; --leggo dalla ROM, quindi i data in sono pronti

            elsif(stato_corrente=reqSended AND okToSend='1') then
                reqToSend<='0';
                stato_corrente<=sendedData;
                data_out<=data_in;
                
            elsif (stato_corrente=sendedData AND ackfromB='1') then --aspetto che l'elaborazione termini 
                load_OperandtoB<='1';
                stato_corrente<=loadOperands;
                
             elsif(stato_corrente= loadOperands AND ackfromB='1') then
                stato_corrente <= ackReceived;
               
            elsif (stato_corrente=ackReceived AND ackfromB='0') then
                 load_OperandtoB<='0';
                 countA<='0'; --il conteggio funziona sul falling edge
                stato_corrente<=startCommunication;
               

            end if;
            
        end if; 
        
    end process;


    
    
    
    
end architecture rtl;