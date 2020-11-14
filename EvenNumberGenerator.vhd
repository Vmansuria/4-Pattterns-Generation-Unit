-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- EvenNumberGenerator.vhd
-- Version 1.0 , 9/17/2020

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
        
entity EvenGenerator is 
 port(
	CLK, RST_Global : in  std_logic;
	RST, DIR, EN : in std_logic_vector(3 downto 0);

	Q : out std_logic_vector(3 downto 0));
       
end EvenGenerator;
        
architecture behavior of EvenGenerator is  
        
signal Present_state: std_logic_vector(3 downto 0);
signal X, Y, RInc, RDec: std_logic;

--X      <= (CLK'event and CLK='1') AND DIR(2)='0' AND EN(2)='1' AND RST(2)='0' AND RST_Global='0';
--Y      <= (CLK'event and CLK='1') AND DIR(2)='1' AND EN(2)='1' AND RST(2)='0' AND RST_Global='0';
--RInc   <= (CLK'event and CLK='1') AND DIR(2)='0' AND EN(2)='1' AND (RST(2)='1' OR RST_Global='1');
--RDec   <= (CLK'event and CLK='1') AND DIR(2)='1' AND EN(2)='1' AND (RST(2)='1' OR RST_Global='1');
begin
	-- syncrhounus RESET signal. 
	-- No trigger on RST, the process only triggers on the Clock (CLK)
	-- X      = CLK AND DIR[2]='0' AND EN[2]='1' AND RST[2]='0' AND RST_Global='0'
	-- Y      = CLK AND DIR[2]='1' AND EN[2]='1' AND RST[2]='0' AND RST_Global='0'
	-- RInc   = CLK AND DIR[2]='0' AND EN[2]='1' AND (RST[2]='1' OR RST_Global='1')
	-- RDec   = CLK AND DIR[2]='1' AND EN[2]='1' AND (RST[2]='1' OR RST_Global='1')



 REG: process (CLK) 
		 begin   
			 
			 if (CLK'event and CLK='1') then 
                if (DIR(2)= '0' AND (RST(2) ='1' or Present_state = "1110" OR RST_Global = '1')) then   
                       Present_state <= "0000";

		elsif (DIR(2)= '1' AND (RST(2) ='1' or Present_state = "0010" OR RST_Global = '1')) then   
                       Present_state <= "1110";

                else
                
					if (DIR(2)='0' AND EN(2)='1' AND RST(2)='0' AND RST_Global='0') then	
					Present_state <= Present_state + 2;
					
					elsif (DIR(2)='1' AND EN(2)='1' AND RST(2)='0' AND RST_Global='0') then
					Present_state <= Present_state - 2;

					elsif (DIR(2)='0' AND EN(2)='1' AND (RST(2)='1' OR RST_Global='1')) then
					Present_state <= "0010";

					elsif (DIR(2)='1' AND EN(2)='1' AND (RST(2)='1' OR RST_Global='1')) then
					Present_state <= "1110";

					end if; 
				end if;
			 end if;     
		 end process; 
		 
	Q <= Present_state;
    
end behavior;
