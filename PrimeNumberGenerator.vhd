-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- PrimeNumberGenerator.vhd
-- Version 1.0 , 9/17/2020

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
        
entity PrimeGenerator is 
 port(
		CLK, RST_Global : in  std_logic;
		RST, DIR, EN : in std_logic_vector(3 downto 0);
      
		Q : out std_logic_vector(3 downto 0));
       
end PrimeGenerator;
        
architecture behavior of PrimeGenerator is  
        
signal Present_state: std_logic_vector(3 downto 0);
signal X, Y, RInc, RDec: std_logic;
--X      <= (CLK'event and CLK='1') AND DIR(0)='0' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0';
--Y      <= (CLK'event and CLK='1') AND DIR(0)='1' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0';
--RInc   <= (CLK'event and CLK='1') AND DIR(0)='0' AND EN(0)='1' AND (RST(0)='1' OR RST_Global='1');
--RDec   <= (CLK'event and CLK='1') AND DIR(0)='1' AND EN(0)='1' AND (RST(0)='1' OR RST_Global='1'); 

begin
	-- syncrhounus CLEAR signal. 
	-- No trigger on CLR, the process only triggers on the Clock (CLK)
	-- X      = CLK AND DIR[0]='0' AND EN[0]='1' AND RST[0]='0' AND RST_Global='0'
	-- Y      = CLK AND DIR[0]='1' AND EN[0]='1' AND RST[0]='0' AND RST_Global='0'
	-- RInc   = CLK AND DIR[0]='0' AND EN[0]='1' AND (RST[0]='1' OR RST_Global='1')
	-- RDec   = CLK AND DIR[0]='1' AND EN[0]='1' AND (RST[0]='1' OR RST_Global='1')







 REG: process (CLK) 
		 begin   
			 
			 if (CLK'event and CLK='1') then 
                if (DIR(0)= '0' AND (RST(0) ='1' or Present_state = "1101" OR RST_Global = '1')) then   
                       Present_state <= "0010";

		     elsif(DIR(0)='1' AND (RST(0)='1' or Present_state = "0010" OR RST_Global = '1')) then   
                       Present_state <= "1101";  

                else
                
					if (DIR(0)='0' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0010") then
					Present_state <= "0011";

					elsif (DIR(0)='0' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0011") then
					Present_state <= "0101";

					elsif (DIR(0)='0' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0101") then
					Present_state <= "0111";

					elsif (DIR(0)='0' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0111") then
					Present_state <= "1011";

					elsif (DIR(0)='0' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "1011") then
					Present_state <= "1101";

					elsif (DIR(0)='1' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "1101") then
					Present_state <= "1011";

					elsif (DIR(0)='1' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "1011") then
					Present_state <= "0111";

					elsif (DIR(0)='1' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0111") then
					Present_state <= "0101";

					elsif (DIR(0)='1' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0101") then
					Present_state <= "0011";

					elsif (DIR(0)='1' AND EN(0)='1' AND RST(0)='0' AND RST_Global='0' AND Present_state = "0011") then
					Present_state <= "0010";

                    elsif (DIR(0)='0' AND EN(0)='1' AND (RST(0)='1' OR RST_Global='1')) then
                    Present_state <= "0010";
                    
                    elsif (DIR(0)='1' AND EN(0)='1' AND (RST(0)='1' OR RST_Global='1')) then
                    Present_state <= "1101";
                    
					end if;


				end if;
			 end if;     
		 end process; 
		 
	Q <= Present_state;
    
end behavior;
