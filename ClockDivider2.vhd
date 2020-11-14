-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- ClockDivider2.vhd
-- Version 1.0 , 9/17/2020

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider2 is
  Port (
        clock : in std_logic;
        RSET : in std_logic;
        s_out : out std_logic
   );
end ClockDivider2;

architecture Behavioral of ClockDivider2 is

signal cnt: std_logic_vector(23 downto 0);
signal s: std_logic;

begin

clockDivider2: process(clock)
  begin
    if clock'event and clock = '1' then
        --every 100 k clocks
        --resets after 50k clocks
            if cnt = "11" then
                s <= not s; -- toggle s
                cnt <="000000000000000000000000";
            else
                cnt <= cnt +1;
            end if;
			
			if(rset='1') then
			
			   cnt <= (others => '0');
			end if;

    end if;
    
  end process clockDivider2;
  
  
s_out <= s;



end Behavioral;
