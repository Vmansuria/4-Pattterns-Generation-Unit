-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- ClockDividerExternal.vhd
-- Version 1.0 , 9/17/2020

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDividerExternal is
  Port (
        clock : in std_logic;
        RSET : in std_logic;
        s_out : out std_logic
   );
end ClockDividerExternal;

architecture Behavioral of ClockDividerExternal is

signal cnt: std_logic_vector(25 downto 0);
signal s: std_logic;

begin

ClockDividerExternal: process(clock)
  begin
    if clock'event and clock = '1' then
        --every 100000000 clocks
        --resets after 50000000 clocks
            if cnt = "10111110101111000010000000" then
                s <= not s; -- toggle s
                cnt <="00000000000000000000000000";
            else
                cnt <= cnt +1;
            end if;
			
			if(rset='1') then
			
			   cnt <= (others => '0');
			end if;

    end if;
    
  end process ClockDividerExternal;
  
  
s_out <= s;



end Behavioral;
