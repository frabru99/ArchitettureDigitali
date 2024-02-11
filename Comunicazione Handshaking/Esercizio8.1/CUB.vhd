library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity CUB is
    port (
        clk: in std_logic;
        reset: in std_logic;

        reqfromA: in std_logic;
        data_in_fromA: in std_logic_vector(8 downto 0);
        data_fromMem: in std_logic_vector(8 downto 0);
        loadOperandfromA: in std_logic;

        --comunicazione
        okToSend: out std_logic;
        acktoA: out std_logic; --lo uso anche come segnale per avanzare il conteggio del contatore interno a B, per le posizioni omologhe

        --sincronizzazione e conteggio
        writeOnMem: out std_logic;
        readfromMem: out std_logic;
        start_adding: out std_logic;
        count_signal: out std_logic;

        X: out std_logic_vector(8 downto 0);
        Y: out std_logic_vector(8 downto 0) --operandi
      
    );
end entity CUB;



architecture rtl of CUB is


    TYPE stati is (waitingReq, okSended, readFromMemState, loadOperands, elaborate, writeOnMemState);

    signal stato_corrente : stati:= waitingReq;
    
begin
    process (clk)
    begin

        if(reset='1') then
            stato_corrente<=waitingReq;
            writeOnMem<='1';
            readfromMem<='1';
            start_adding<='0';
            okToSend<='0';
            acktoA<='0';
            
        end if;

        writeOnMem<='1';
        readfromMem<='1';
        start_adding<='0';
        count_signal<='1';

        
        
        if(rising_edge(clk)) then

            if(stato_corrente= waitingReq AND reqfromA='1') then

                stato_corrente<= okSended;
                okToSend<='1';

            elsif(stato_corrente=okSended) then 
                okToSend<='0';
                readfromMem<='0';
                acktoA<='1';
                stato_corrente<=readFromMemState;
                
            elsif(stato_corrente=readFromMemState AND loadOperandfromA='1') then
                X<= data_in_fromA;
                Y<= data_fromMem;

                stato_corrente<= loadOperands;

            elsif(stato_corrente=loadOperands) then 
                start_adding<='1'; --svolgo operazione 
                stato_corrente<=elaborate;

            elsif (stato_corrente=elaborate) then
                stato_corrente<=writeOnMemState;
                writeOnMem<='0';
            elsif (stato_corrente= writeOnMemState) then 
                count_signal<='0';
                stato_corrente<=waitingReq;
                acktoA<='0';

            end if;
            


        end if;
    

    end process;
    
    
    
end architecture rtl;