-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- ClockDivider.vhd
-- Version 1.0 , 9/17/2020
---

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
  Port (
        clock : in std_logic;
        RSET : in std_logic;
        s_out : out std_logic
   );
end ClockDivider;

architecture Behavioral of ClockDivider is

signal cnt: std_logic_vector(23 downto 0);
signal s: std_logic;

begin

clockDivider: process(clock)
  begin
    if clock'event and clock = '1' then
        --every 200000 clocks
        --resets after 100000 clocks
            if cnt = "000000011000011010100000" then
                s <= not s; -- toggle s
                cnt <="000000000000000000000000";
            else
                cnt <= cnt +1;
            end if;
			
			if(rset='1') then
			
			   cnt <= (others => '0');
			end if;

    end if;
    
  end process clockDivider;
  
  
s_out <= s;



end Behavioral;
